//
//  TargetStore.swift
//  AgareeGames
//
//  Created by 위사모바일 on 11/1/23.
//

import Foundation
import RxSwift

protocol TargetFetchable {
    func fetchURL(_ :HttpBaseResource) -> Observable<[String:String]>
}

class TargetStore:TargetFetchable {
    func fetchURL(_ source:HttpBaseResource) -> RxSwift.Observable<[String : String]> {
        struct Response {
            let targets:[[String:Any]]
        }
        return NetworkService.shared.fetchJsonRX(resource: source)
            
        
        
    }
    func fetchImage(_ dic:[String:String]) -> Observable<[GamePlayModel]> {
        
        return NetworkService.shared.fetchImageRX2(source: dic)
    }
}
