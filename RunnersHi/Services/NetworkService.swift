//
//  NetworkService.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import Foundation

// 컴플리션 핸들러 추가해야함. 콜백함수의 타입을 모르겟음 서버하고 고민해보기
class NetworkService{
    static func makeReq(resource:HttpBaseResource){
        URLSession.shared.dataTask(with: resource.request()) { data, resp, err in
            
        }
    }
}
