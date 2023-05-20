//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import Foundation

// completionBlock 추가하기
class NetworkService{
    static func makeReq(resource:HttpBaseResource){
        URLSession.shared.dataTask(with: resource.request()) { data, resp, err in
            
        }
    }
}
