//
//  TargetStore.swift
//  AgareeGames
//
//  Created by 위사모바일 on 11/1/23.
//

import Foundation
import RxSwift

protocol TargetFetchable {
    func fetchTarget(_ :HttpBaseResource) -> Observable<[String:Any]>
}

class TargetStore:TargetFetchable {
    func fetchTarget(_ source:HttpBaseResource) -> RxSwift.Observable<[String : Any]> {
        struct Response {
            let targets:[[String:Any]]
        }
        return NetworkService.fetchJSONRx(resource: source)
    }
    
    
}
