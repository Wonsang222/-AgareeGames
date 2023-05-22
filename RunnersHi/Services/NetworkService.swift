//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import UIKit

// completionBlock 추가하기 && basecontroller 추가해야함..

// navigation controller로 해야하나 그래야 poptoroot으로 이동 수월
class NetworkService{
    
    private static let session = URLSession(configuration: configuration)
    
    private static let configuration:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
//        configuration.networkServiceType = .responsiveData
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
    
    static func fetchImage(_ data:Dictionary<String,AnyObject>) async throws -> [GuessWhoPlayModel]{
        // data 순회 -> url  이미지 불러오기 다운 백그라운드로 날려버리기
        var result:Array<GuessWhoPlayModel> = []
        for (name, url) in data{
            print(name)
            let dbName = name
            guard let stringUrl = url as? String else {fatalError("에러추가하세요")}
            print(stringUrl)
            let dbUrl = URL(string: stringUrl)
            guard let dbUrl = dbUrl else {fatalError("에러추가")}
            print("1213",dbUrl)
            let (data, response) = try await session.data(from:dbUrl)
            print(12312312312312312)
            print(data)
            print(response)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("에러추가하세요")}
            print("통과")
            let urlPhoto = UIImage(data: data)
            // 이미지가 아닐때...
            guard let urlPhoto = urlPhoto else {fatalError("에러추가하세요")}
            print("사진")
            let model = GuessWhoPlayModel(name: dbName, photo: urlPhoto)
            result.append(model)
        }
        return result
    }
}
