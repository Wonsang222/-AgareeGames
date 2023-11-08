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
    
    let serialQueue = DispatchQueue(label: "serial")
    let concurrnetQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
    
    let sem = DispatchSemaphore(value: 1)
    
    let configuration:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.networkServiceType = .responsiveData
        configuration.timeoutIntervalForRequest = 5
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
    
    func fetchImage(_ data:Dictionary<String,Any>) async -> [GamePlayModel]{
        // data 순회 -> url  이미지 불러오기 백그라운드로 날려버리기
        var result:Array<GamePlayModel> = []
        for (name, url) in data {
            let dbName = name
            var photo:UIImage?
            do{
                guard let stringUrl = url as? String,
                      let dbUrl = URL(string: stringUrl)
                else {throw NetworkError.notconnected }
                
                if let isSaved =  DataManager.shared.fetchModel(targetName: dbName){
                    photo = UIImage(data: isSaved.photo)
                } else {
                    let (data, response) = try await URLSession(configuration: configuration).data(from:dbUrl)
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.notconnected }
                    photo = UIImage(data: data)
                    DataManager.shared.createModel(name: dbName, photo: data)
                }
                guard let urlPhoto = photo else { throw NetworkError.notconnected }
                let model = GamePlayModel(name: dbName, photo: urlPhoto)
                result.append(model)
            } catch{
                let joker = GamePlayModel(name: "조커", photo: UIImage(named: "joker")!)
                result.append(joker)
            }
        }
        return result
    }
    
    func temp2(_ dic:[String:Any], completion:@escaping(Result<GamePlayModel, Error>) -> Void) {
        concurrnetQueue.async { [unowned self] in
            for ( _ , obj) in dic.enumerated() {
                let name = obj.key
                let url = URL(string: obj.value as! String)!
                let req = URLRequest(url: url)
                URLSession(configuration: self.configuration).dataTask(with: req) { [unowned self] data, res, err in
                    if err != nil  {
                        print(err!)
                        return
                    }
                    guard let res = res as? HTTPURLResponse,
                          (200...299).contains(res.statusCode) else { return }
                    
                    guard let data = data else { return }
                    
                    let img = UIImage(data: data)
                    let target = GamePlayModel(name: name, photo: img)
                    
                    self.sem.wait()
                    completion(.success(target))
                    self.sem.signal()
                }
                
            }
            
        }
    }
    
    func fetchImageRX(source:Dictionary<String,String>) -> Observable<[GamePlayModel]> {
        let ob = source.map{ name, url in
            return Observable<GamePlayModel>.create { [unowned self] observer in
                guard let url = URL(string: url) else {
                    observer.onError(MyServer(statusCode: 500).getError())
                    return Disposables.create()
                }
                var req = URLRequest(url: url)
                req.cachePolicy = .returnCacheDataElseLoad
                let task = URLSession(configuration: self.configuration).dataTask(with: req) { data, res, err in
                    
                    if let error = err {
                        observer.onError(error)
                        return
                    }

                    guard let httpResponse = res as? HTTPURLResponse,
                          (200...299) ~= httpResponse.statusCode else {
                        observer.onError(MyServer(statusCode: 400).getError())
                        return
                    }
                    guard let data = data, let img = UIImage(data: data) else {
                        observer.onError(MyServer(statusCode: 400).getError())
                        return
                    }
                    let model = GamePlayModel(name: name, photo: img)
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
