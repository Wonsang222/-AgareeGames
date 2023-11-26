//
//  BaseViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/03.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel:NSObject{
    let sceneCoordinator:Coordinator
    let errorMessage = BehaviorSubject<Error?>(value: nil)
    
    init(sceneCoordinator: Coordinator) {
        self.sceneCoordinator = sceneCoordinator
    }
}
