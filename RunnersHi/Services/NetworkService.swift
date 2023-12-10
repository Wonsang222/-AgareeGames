//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import UIKit
import RxSwift

final class NetworkService{
    
    static let shared = NetworkService()
    private init () {}

    let configuration:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.networkServiceType = .responsiveData
//        configuration.waitsForConnectivity = true
//        configuration.timeoutIntervalForResource = 2
        configuration.httpAdditionalHeaders = ["Authorization":Global.UUID, "User-Agent": Global.BUNDLEIDENTIFIER]
        return configuration
    }()
    
    func fetchJSON(httpbaseresource:HttpBaseResource) async throws -> [String:Any] {
        var result:[String:Any] = [:]
        let (data, response)  = try await URLSession(configuration: configuration).data(for: httpbaseresource.getRequest())
        guard let status = response as? HTTPURLResponse,
              (200...299) ~= status.statusCode else {
            let error = MyServer(statusCode: (response as? HTTPURLResponse)!.statusCode).getError()
            throw error
        }
        let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String:Any]
        result = jsonData
        return result
    }
    
    func fetchJsonRX(resource:HttpBaseResource) -> Observable<[String:String]> {
        return Observable.create { [unowned self] observer in
            let task = URLSession(configuration: self.configuration).dataTask(with: resource.getRequest()) { data, res, err in
                if err != nil {
                    observer.onError(MyServer(statusCode: 500).getError())
                    return
                }
                guard let res = res as? HTTPURLResponse,
                      (200...299) ~= res.statusCode else {
                    let error = MyServer(statusCode: 400).getError()
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    let error = MyServer(statusCode: 400).getError()
                    observer.onError(error)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data,
                                                                options: JSONSerialization.ReadingOptions()) as! [String:String]
                    observer.onNext(json)
                    observer.onCompleted()
                } catch {
                    let error = MyServer(statusCode: 400).getError()
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

    func fetchImageRX<T:Playable>(source:Dictionary<String,String>) -> Observable<[T]>  {
        let ob = source.map{ name, url in
            return Observable<T>.create { [unowned self] observer in
                guard let url = URL(string: url) else {
                    observer.onError(MyServer(statusCode: 500).getError())
                    return Disposables.create()
                }
                var req = URLRequest(url: url)
                req.cachePolicy = .useProtocolCachePolicy
                let task = URLSession(configuration: self.configuration).dataTask(with: req) { data, res, err in
                    
                    if let error = err {
                        let error = MyServer(statusCode: 500).getError()
                        print("에러 1")
                        observer.onError(error)
                        return
                    }

                    guard let resp = res as? HTTPURLResponse else {
                        observer.onError(MyServer(statusCode: 400).getError())
                        print("에러 2")
                        return
                    }
                    
                    let statusCode = resp.statusCode
                    
                    guard (200...299) ~= statusCode else {
                        observer.onError(MyServer(statusCode: statusCode).getError())
                        print("에러 3")
                        return
                    }
                    
                    guard let data = data, let img = UIImage(data: data) else {
                        observer.onError(MyServer(statusCode: 400).getError())
                        print("에러 5")
                        return
                    }
                    let model = T(name: name, photo: img)
                    observer.onNext(model)
                    observer.onCompleted()
                }
                task.resume()
                
                return Disposables.create{
                    task.cancel()
                }
            }
                }
        return Observable.zip(ob)
    }
}
