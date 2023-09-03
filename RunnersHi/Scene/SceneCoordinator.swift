//
//  SceneCoordinator.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/03.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

extension UIViewController{
    var sceneViewController:UIViewController{
        return self.children.last ?? self
    }
}

class SceneCoordinator:SceneCoordinatorType, HasDisposeBag{
    
    private var window:UIWindow
    private var currentVC:UIViewController
    
    required init(window:UIWindow){
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> RxSwift.Completable {
        
        let target = scene.instantiate()
        
        let subject = PublishSubject<Never>()
        
        switch style{
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            window.makeKeyAndVisible()
            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.rx.willShow
                .withUnretained(self)
                .subscribe(onNext: { coordinator, evt in
                    coordinator.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: disposeBag)
            
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: true){
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        
        return subject.asCompletable()
    }
}
