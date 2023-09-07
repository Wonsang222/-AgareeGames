//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

class AppCoordinator:Coordinator{
    var navigationController: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: CustomUINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> Completable  {
        let child = PregameCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        return child.start()
    }
}
