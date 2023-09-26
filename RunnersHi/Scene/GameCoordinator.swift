//
//  GameCoordinator.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/06.
//

import UIKit
import RxSwift
import RxCocoa

class GameCoordinator: Coordinator {
    
    var navi: CustomUINavigationController!
    var child = [Coordinator]()
    weak var parent: Coordinator?
    var bag = DisposeBag()
    
    func start() -> RxSwift.Completable {
        let subject = PublishSubject<Never>()
        
        
        return subject.asCompletable()
        
    }

    
//    navi.rx.willShow
//        .withUnretained(self)
//        .subscribe(onNext: { coordinator, event in
//            coordinator.navigationController = event.viewController.navigationController! as! CustomUINavigationController
//        })
//        .disposed(by: bag)
    
}
