//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit

class AppCoordinator:Coordinator{
    
    var navi: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    var window: UIWindow
    
    init(navi: CustomUINavigationController, window:UIWindow) {
        self.navi = navi
        self.window = window
    }
    
    func start(){
        let child = PregameCoordinator(navi: navi)
        child.parentCoordinator = self
        childCoordinators.append(child)
        window.rootViewController = child.navi
        window.makeKeyAndVisible()
    }
}
