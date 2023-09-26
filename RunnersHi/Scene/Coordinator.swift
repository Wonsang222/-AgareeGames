//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa


// 추가할것 각 coordinator 마다 다른 특성의 navigationcontroller 갖고있음 좋을듯 - uinavigationconroller 공부 다시 해야함

protocol Coordinator:AnyObject{
    
    var navi:CustomUINavigationController! { get set }
    var child:[Coordinator] { get set }
    var parent:Coordinator? {  get set }
    var bag:DisposeBag { get set }
}

extension Coordinator{
    
    @discardableResult
    func transition(to scene:Scene, using style:TransitionStyle, animation:Bool) -> Completable{
        let subject = PublishSubject<Never>()
        
        let target = scene.instantiate()
        
        switch style{
        case .push:
            navi.rx.willShow
                .withUnretained(self)
                .subscribe(onNext: { coordinator, evt in
                    coordinator.navi = (evt.viewController as! CustomUINavigationController)
                })
                .disposed(by: bag)
            
            navi.pushViewController(target, animated: true)
            subject.onCompleted()
        case .back:
            print(123)
            subject.onCompleted()
        case .root:
            navi.setViewControllers([target], animated: true)
            subject.onCompleted()
        }
        return subject.asCompletable()
    }
        
    @discardableResult
    func childDidFinish(_ target:Coordinator) -> Completable{
        let subject = PublishSubject<Never>()
        
        for (idx, coordinator) in child.enumerated(){
            if coordinator === target{
                child.remove(at: idx)
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


