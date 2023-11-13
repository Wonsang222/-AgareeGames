//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa


extension UIViewController {
    var crnvc:UIViewController {
        return self.children.last ?? self
    }
}

class Coordinator {
    
    var navigationVC:BaseNavigationController
    var children = [Coordinator]()
    var parent:Coordinator?
    let window:UIWindow
    private var bag = DisposeBag()
    
    init(navigationVC: BaseNavigationController, parent: Coordinator? = nil, window: UIWindow) {
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
                    coordinator.navigationVC = (evt.viewController.navigationController as! BaseNavigationController)
                })
                .disposed(by: bag)
            
            navigationVC.pushViewController(target, animated: true)
            subject.onCompleted()
        case .back:
            subject.onCompleted()
        case .root:
            navigationVC.setViewControllers([target], animated: true)
            subject.onCompleted()
            break
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    final func close(animated:Bool) -> Completable {
        let sub = PublishSubject<Never>()
        
        let currentVC = navigationVC.topViewController!
        
        if let presentingVC = currentVC.presentingViewController {
            currentVC.dismiss(animated: animated) {
                sub.onCompleted()
            }
        } else {
            guard navigationVC.popViewController(animated: animated) != nil else {
                sub.onError(NSError(domain: "cannotPop", code: 11))
                return sub.asCompletable()
            }
            sub.onCompleted()
        }
        return sub.asCompletable()
    }
    
    @discardableResult
    final func childDidFinish(_ target:Coordinator) -> Completable {
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
