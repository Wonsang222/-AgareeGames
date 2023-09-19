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
    case back
}

enum Scene{
    case pregame(PregameViewModel)
    case test(ResultViewModel)
}

extension Scene{
    func instantiate() -> BaseController{
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
            return BaseController()
        }
    }
}

protocol Coordinator:AnyObject{
    var navi:CustomUINavigationController { get set }
    var childCoordinators:[Coordinator] { get set }
    
    func start()
}

extension Coordinator{
    
    @discardableResult
    func transition(to scene:Scene, using style:TransitionStyle, animation:Bool) -> Completable{
        let subject = PublishSubject<Never>()
        
        let target = scene.instantiate()
        
        switch style{
        case .push:
            print(123)
            subject.onCompleted()
        case .back:
            print(123)
            subject.onCompleted()
        default:
            subject.onError(NSError(domain: "Err", code: 1))
        }
        return subject.asCompletable()
    }
}


protocol Coordinating{
    var coordinator:Coordinator { get set }
    
}


