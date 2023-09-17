//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift

protocol Coordinator:AnyObject{
    var navigationController:CustomUINavigationController { get set }
    var childCoordinators:[Coordinator] { get set }
    
}


protocol Coordinating{
    var coordinator:Coordinator { get set }
    
}
