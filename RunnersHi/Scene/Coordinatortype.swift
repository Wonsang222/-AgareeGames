//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit

protocol Coordinator{
    var childCoordinators:[Coordinator] { get set }
    var navigationController:UINavigationController { get set }
    
    func start()
}
