//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa


class Coordinator1 {
    var navigationVC:BaseNavigationController
    var children = [Coordinator1]()
    var parent:Coordinator1?
    let window:UIWindow
    let bag = DisposeBag()
    
    init(navigationVC: BaseNavigationController, parent: Coordinator1? = nil, window: UIWindow) {
        self.navigationVC = navigationVC
        self.parent = parent
        self.window = window
    }
    
    @discardableResult
    final func transition(to scene:Scene, using style:TransitionStyle, animation:Bool) -> Completable {
        let subject = PublishSubject<Never>()
        let target = scene.instantiate()
        
        switch style {
        case .push:
            navigationVC.rx.willShow
                .withUnretained(self)
                .subscribe(onNext: { coordinator, evt in
                    coordinator.navigationVC = (evt.viewController as! BaseNavigationController)
                })
                .disposed(by: bag)
            
            navigationVC.pushViewController(target, animated: true)
            subject.onCompleted()
            
        case .back:
            subject.onCompleted()
            
        case .root:
            navigationVC.setViewControllers([target], animated: true)
            subject.onCompleted()
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    final func childDidFinish(_ target:Coordinator1) -> Completable {
        let subject = PublishSubject<Never>()
        
        for (idx, coordinator) in children.enumerated(){
            if coordinator === target{
                children.remove(at: idx)
                subject.onCompleted()
                break
            }
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    func start() -> Completable {
        return Completable.create { observer in
            
            // Abstract
            
            return Disposables.create()
        }
    }
}


//protocol Coordinator:AnyObject{
//    
//    var navi:BaseNavigationController! { get set }
//    var children:[Coordinator] { get set }
//    var parent:Coordinator? {  get set }
//    var window:UIWindow { get set }
//    var bag:DisposeBag { get set }
//}
//
//extension Coordinator{
//    
//    // 수정해야함
//    @discardableResult
//    func transition(to scene:Scene, using style:TransitionStyle, animation:Bool) -> Completable{
//        let subject = PublishSubject<Never>()
//        let target = scene.instantiate()
//        
//        switch style {
//        case .push:
//            navi.rx.willShow
//                .withUnretained(self)
//                .subscribe(onNext: { coordinator, evt in
//                    coordinator.navi = (evt.viewController as! BaseNavigationController)
//                })
//                .disposed(by: bag)
//            
//            navi.pushViewController(target, animated: true)
//            subject.onCompleted()
//            
//        case .back:
//            subject.onCompleted()
//            
//        case .root:
//            navi.setViewControllers([target], animated: true)
//            subject.onCompleted()
//        }
//        return subject.asCompletable()
//    }
//        
//    @discardableResult
//    func childDidFinish(_ target:Coordinator) -> Completable{
//        let subject = PublishSubject<Never>()
//        
//        for (idx, coordinator) in children.enumerated(){
//            if coordinator === target{
//                children.remove(at: idx)
//                subject.onCompleted()
//                break
//            }
//        }
//        return subject.asCompletable()
//    }
//}
//
