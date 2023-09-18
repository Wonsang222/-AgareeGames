//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift

enum TransitionStyle{
    case push
    case root
    case back
}

enum Scene{
    case pregame(PregameViewModel)
    case test(ResultViewModel)
}

extension Scene{
    func instantiate(from:BaseController) -> UIViewController{
        switch self{
        case .pregame(let viewmodel):
            var vc = PreGameController()
            DispatchQueue.main.async {
                vc.bind(viewmodel: viewmodel)
            }
            return vc
        case .test(let viewmodel):
            var vc = ResultController(isWin: true)
            return vc
        @unknown default:
            return UIViewController()
        }
        
    }
}

protocol Coordinator:AnyObject{
    var navigationController:CustomUINavigationController { get set }
    var childCoordinators:[Coordinator] { get set }
    
    func transition(to scene:Scene, using style:TransitionStyle, animation:Bool)
    
}


protocol Coordinating{
    var coordinator:Coordinator { get set }
    
}


