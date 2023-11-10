//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift

class AppCoordinator1:Coordinator {
    
    @discardableResult
    override func start() -> Completable {
        let sub = PublishSubject<Never>()
        // start point
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        return sub.asCompletable()
    }
}
