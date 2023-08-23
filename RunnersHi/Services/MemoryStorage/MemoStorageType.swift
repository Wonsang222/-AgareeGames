//
//  MemoStorageType.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/08/23.
//

import Foundation
import RxSwift

protocol MemoStorageType{
    @discardableResult
    func createModel(name:String, photo:UIImage) -> Observable<Void>
    
    
    func findModel(name:String) -> Observable<Bool>
    
    
}
