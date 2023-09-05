//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit

class MainCoordinator:Coordinator{
    var navigationController: UINavigationController?
    
    func start() {
        var vc:UIViewController & Coordinating = PreGameController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func eventOccured(with type: Event) {
        
    }
    
    
}
