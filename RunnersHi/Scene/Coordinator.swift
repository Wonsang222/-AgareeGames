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
    case root
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
        case .test(_):
            var vc = ResultController(isWin: true)
            return vc
        @unknown default:
            break
        }
    }
}

protocol Coordinator:AnyObject{
    var navi:CustomUINavigationController { get set }
    var childCoordinators:[Coordinator] { get set }
    
    @discardableResult
    func start() -> Completable
}

extension Coordinator{
    
    @discardableResult
    func transition(to scene:Scene, using style:TransitionStyle, animation:Bool) -> Completable{
        let subject = PublishSubject<Never>()
        
        let target = scene.instantiate()
        
        switch style{
        case .push:
            navi.pushViewController(target, animated: true)
            subject.onCompleted()
        case .back:
            print(123)
            subject.onCompleted()
        case .root:
            print(123)
        }
        return subject.asCompletable()
    }
    
    
    @discardableResult
    func childDidFinish(_ child:Coordinator) -> Completable{
        let subject = PublishSubject<Never>()
        for (idx, coordinator) in childCoordinators.enumerated(){
            if coordinator === child{
                childCoordinators.remove(at: idx)
                subject.onCompleted()
                break
            }
        }
        return subject.asCompletable()
    }
}


protocol Coordinating{
    var coordinator:Coordinator { get set }
    
}


