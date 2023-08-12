//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import UIKit
import RxSwift

final class NetworkService{
    
    private static let configuration:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.networkServiceType = .responsiveData
        configuration.timeoutIntervalForRequest = 5
        configuration.httpAdditionalHeaders = ["Authorization":Global.UUID, "User-Agent": Global.BUNDLEIDENTIFIER]
        return configuration
    }()
    
    static func fetchJSON(httpbaseresource:HttpBaseResource) async throws -> [String:Any]{
        var result:[String:Any] = [:]
        let (data, response)  = try await URLSession(configuration: configuration).data(for: httpbaseresource.request())
        guard let status = response as? HTTPURLResponse,
              (200...299) ~= status.statusCode else {
            let error = MyServer(statusCode: (response as? HTTPURLResponse)!.statusCode).emitError()
            throw error
        }
        // 내 서버이기에, codable 사용하지않음.
        let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String:Any]
        result = jsonData
        return result
    }
    
    // rx를 위한 completionHandler 형태로 변환
    private static func fetchJSON(resource:HttpBaseResource,completion:@escaping (Result<Dictionary<String,Any>, Error>) -> Void) {
        URLSession(configuration: configuration).dataTask(with: resource.request()) { data, response, err in
            if err != nil{
                let err = MyServer(statusCode: 500).emitError()
                completion(.failure(err))
            }
            
            guard let status = response as? HTTPURLResponse,
                  (200...299) ~= status.statusCode else {
                let error = MyServer(statusCode: (response as? HTTPURLResponse)!.statusCode).emitError()
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            var jsonData = [String:Any]()
            do{
                jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String:Any]
            } catch{
                
            }
            completion(.success(jsonData))
        
        }
        .resume()
    }
    
    static func fetchJSONRx(resource:HttpBaseResource) -> Observable<[String:Any]> {
        return Observable.create { emitter in
            fetchJSON(resource: resource) { result in
                switch result{
                case .success(let json):
                    break
                case .failure(let err):
                    break
                }
                
                
            }
            return Disposables.create()
        }
    }
    
    /*
     1. 임시캐시
     2. image를 불러오지 못했을 경우, joker 사용 - throws를쓰지않음. 메서드 내부에서 에러처리
     3. 조커는 무조건 정답으로 쳐야한다. name = * 이면 wildcard
     */
    
    static func fetchImage(_ data:Dictionary<String,Any>) async -> [GuessWhoPlayModel]{
        // data 순회 -> url  이미지 불러오기 백그라운드로 날려버리기
        var result:Array<GuessWhoPlayModel> = []
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
                let model = GuessWhoPlayModel(name: dbName, photo: urlPhoto)
                result.append(model)
            } catch{
                let joker = GuessWhoPlayModel(name: "조커", photo: UIImage(named: "joker")!)
                result.append(joker)
            }
        }
        return result
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
}
