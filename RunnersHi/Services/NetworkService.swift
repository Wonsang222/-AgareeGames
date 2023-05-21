//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import Foundation

// completionBlock 추가하기 && basecontroller 추가해야함..
class NetworkService{
    func fetchJSON(httpbaseresource:HttpBaseResource, controller:BaseController){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        // 타임아웃 1001 임 에러처리해야함.....
        // 메인쓰레드에 락 걸어야함
        // 공통헤더
//        configuration.httpAdditionalHeaders =
        configuration.networkServiceType = .responsiveData
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: httpbaseresource.request()) { data, response, error in
            if let error = error{
                controller.alert(message: "네트워크 오류", agree: nil, disagree: nil)
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                controller.alert(message: "네트워크 오류", agree: nil, disagree: nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                controller.alert(message: "네트워크 오류", agree: nil, disagree: nil)
                return
            }
            
            guard let data = data else {
                fatalError("data binding")
            }
            
            
        }
        
        task.resume()
    }
}
