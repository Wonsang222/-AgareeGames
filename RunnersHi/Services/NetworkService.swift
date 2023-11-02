//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import UIKit
import RxSwift

final class NetworkService{
    
    static let serialQueue = DispatchQueue(label: "serial")
    
    private static let configuration:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.networkServiceType = .responsiveData
        configuration.timeoutIntervalForRequest = 5
        configuration.httpAdditionalHeaders = ["Authorization":Global.UUID, "User-Agent": Global.BUNDLEIDENTIFIER]
        return configuration
    }()
    
    static func fetchJSON(httpbaseresource:HttpBaseResource) async throws -> [String:Any]{
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
    
    static func fetchJsonRX(resource:HttpBaseResource) -> Observable<[String:Any]> {
        return Observable.create { observer in
            let task = URLSession(configuration: configuration).dataTask(with: resource.getRequest()) { data, res, err in
                if err != nil {
                    observer.onError(MyServer(statusCode: 500).getError())
                }
                guard let res = res as? HTTPURLResponse,
                      (200...299) ~= res.statusCode else {
                    let error = MyServer(statusCode: 400).getError()
                    observer.onError(error)
                }
                
                guard let data = data else {
                    let error = MyServer(statusCode: 400).getError()
                    observer.onError(error)
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data,
                                                                options: JSONSerialization.ReadingOptions()) as! [String:Any]
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
    
    static func fetchImageRX(source:Dictionary<String,Any>) -> Observable<[GamePlayModel]> {
        return Observable.create { observer in
            for (idx, obj) in source.enumerated() {
                
            }
            return Disposables.create {
                
            }
        }
    }
    
    
    // 이 코드 dispatch group ++ serial 이용해서 다시 바꿔봐도 재밋을듯
    static func fetchImage(_ data:Dictionary<String,Any>) async -> [GamePlayModel]{
        // data 순회 -> url  이미지 불러오기 백그라운드로 날려버리기
        var result:Array<GamePlayModel> = []
        for (name, url) in data{
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
    
    static func temp2(_ dic:[String:Any], completion:@escaping([GamePlayModel]) -> Void) {
        
        // lazy var 동시접근 막아야한다. -> 읽기는 괜찮나
        
        
        for (name, url) in dic {
            serialQueue.async {
                
            }
        }
    }
    
    
}
    // 캐시에 있으면 사용, 없으면 temp cache를 봄.
    //    private static func cacheCheck(_ name:String) -> UIImage?{
    //        let cacheKey = name as NSString
    //        let dbCache = TempCache.shared.cache
    //        if let cacheImage = ImageCacheManager.shared.object(forKey: cacheKey){
    //            return cacheImage
    //        } else if let dbPhoto = dbCache[name] {
    //            return dbPhoto
    //        }
    //        return nil
    //    }

