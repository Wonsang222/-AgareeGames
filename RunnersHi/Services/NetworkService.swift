//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import UIKit

// completionBlock 추가하기 && basecontroller 추가해야함..

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
        // 고민좀 해봐야함
//        configuration.timeoutIntervalForRequest = 10
//        configuration.timeoutIntervalForResource = 2
        return configuration
    }()
        
    static func fetchJSON(httpbaseresource:HttpBaseResource, controller:BaseController) async throws -> [String:AnyObject]{
        let (data, response)  = try await session.data(for: httpbaseresource.request())
        guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 404) else { fatalError("에러처리하세요 여기에")}
        let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String:AnyObject]
        return jsonData
    }
    
    // 임시캐시 추가
    static func fetchImage(_ data:Dictionary<String,AnyObject>) async throws -> [GuessWhoPlayModel]{
        // data 순회 -> url  이미지 불러오기 백그라운드로 날려버리기
        var result:Array<GuessWhoPlayModel> = []
        for (name, url) in data{
            let dbName = name
            var photo:UIImage?
            if cacheCheck(url as! String) == nil{
                // 캐시에 없을때
                guard let stringUrl = url as? String else {fatalError("에러추가하세요")}
                let dbUrl = URL(string: stringUrl)
                guard let dbUrl = dbUrl else {fatalError("에러추가")}
                let (data, response) = try await session.data(from:dbUrl)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("에러추가하세요")}
                photo = UIImage(data: data)
            } else {
                photo = cacheCheck(url as! String)
            }
            guard let urlPhoto = photo else {fatalError("에러추가하세요")}
            let model = GuessWhoPlayModel(name: dbName, photo: urlPhoto)
            result.append(model)
        }
        return result
    }
    
    private static func cacheCheck(_ url:String) -> UIImage?{
        let cacheKey = url as NSString
        if let cacheImage = ImageCacheManager.shared.object(forKey: cacheKey){
            let result = cacheImage
            return result
        }
        return nil
    }
}
