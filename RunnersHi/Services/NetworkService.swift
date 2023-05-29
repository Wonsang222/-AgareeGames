//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import UIKit

// navigation controller로 해야하나 그래야 poptoroot으로 이동 수월

/*
 
 처음 시작할때,
 userdefault에 키면 날짜 저장. 없으면 첨 저장.
 저장하기전에 최종 날짜 불러옴. 대조 -> 7일 지나면 디스크 캐취 삭제
 최종 저장 날짜로부터 7일 지난 것들 쿼리로불러와서 싹 지움.
 
 ---------------------------------------------------------------------
 
 1. 이미지가 memory cache(NSCache)에 있는지 확인하고
 
 원하는 이미지가 없다면
 
 2. disk cache(UserDefault 혹은 기기Directory에있는 file형태)에서 확인하고
 
 있다면 memory cache에 추가해주고 다음에는 더 빨리 가져 올수 있도록 할 수 있어요
 
 이마저도 없다면
 
 3. 서버통신을 통해서 받은 URL로 이미지를 가져와야해요
 
 이때 서버통신을 통해서 이미지를 가져왔으면 memory와 disk cache에 저장해줘야 캐시처리가 되겠죠?!
 
 
 */


final class NetworkService{
    
    private static let session = URLSession(configuration: configuration)
    
    private static let configuration:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.networkServiceType = .responsiveData
        configuration.timeoutIntervalForRequest = 20
        configuration.httpAdditionalHeaders = ["Authorization":Global.UUID, "User-Agent": Global.BUNDLEIDENTIFIER]
        return configuration
    }()
    /*
     1. 네트워크 타임아웃시 - 1. 종료를 시킨다. 2. poptoroot로 돌아간다
     */
    static func fetchJSON(httpbaseresource:HttpBaseResource, controller:BaseController) async throws -> [String:AnyObject]{
        var result:[String:AnyObject] = [:]
        do{
            let (data, response)  = try await session.data(for: httpbaseresource.request())
            guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 404) else {
                throw NetworkError.serverError
            }
            let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String:AnyObject]
            result = jsonData
            return result
        } catch{
        
        }
        throw NetworkError.serverError
    }
    
    /*
     1. 임시캐시
     2. image를 불러오지 못했을 경우, joker 사용
     3. 조커는 무조건 정답으로 쳐야한다. name = * 이면 wildcard
     */
    static func fetchImage(_ data:Dictionary<String,AnyObject>, contorller:BaseController) async throws -> [GuessWhoPlayModel]{
        // data 순회 -> url  이미지 불러오기 백그라운드로 날려버리기
        var result:Array<GuessWhoPlayModel> = []
        for (name, url) in data{
            let dbName = name
            var photo:UIImage?
            
            do{
                if cacheCheck(url as! String) != nil{
                    photo = cacheCheck(url as! String)
                    let model = GuessWhoPlayModel(name: dbName, photo: photo!, url: url as! String)
                    result.append(model)
                    continue
                } else {
                    guard let stringUrl = url as? String else {fatalError("에러추가하세요")}
                    let dbUrl = URL(string: stringUrl)
                    //지나갈 수 있는 에러 -> 조커
                    guard let dbUrl = dbUrl else { throw NetworkError.notconnected }
                    // network 에러 -> 조커
                    let (data, response) = try await session.data(from:dbUrl)
                    // network 에러 -> 조커
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.notconnected }
                    photo = UIImage(data: data)
                    //사진이 아니라 먼가 이상한게 옴 -> 조커
                    guard let urlPhoto = photo else { throw NetworkError.disconnected }
                    let model = GuessWhoPlayModel(name: dbName, photo: urlPhoto, url:url as! String)
                    result.append(model)
                    continue
                }
            } catch{
                let joker = GuessWhoPlayModel(name: "조커", photo: UIImage(named: "joker")!, url: "joker")
                result.append(joker)
            }
        }
        return result
    }
    // 캐시에 있으면 사용, 없으면 temp cache를 봄.
    private static func cacheCheck(_ url:String) -> UIImage?{
        let cacheKey = url as NSString
        let dbCache = TempCache.shared.cache
        if let cacheImage = ImageCacheManager.shared.object(forKey: cacheKey){
            return cacheImage
        } else if let dbPhoto = dbCache[url] {
            return dbPhoto
        }
        return nil
    }
}
