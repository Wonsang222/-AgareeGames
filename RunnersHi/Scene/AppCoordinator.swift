//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift

class AppCoordinator:Coordinator{
    
    var navi: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    var window: UIWindow
    
    init(navi: CustomUINavigationController, window:UIWindow) {
        self.navi = navi
        self.window = window
    }
    
    @discardableResult
    func start() -> Completable{
        let subject = PublishSubject<Never>()
        let child = PregameCoordinator(navi: navi)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
        window.rootViewController = child.navi
        window.makeKeyAndVisible()
        print(99)
        subject.onCompleted()
        return subject.asCompletable()
    }
}
