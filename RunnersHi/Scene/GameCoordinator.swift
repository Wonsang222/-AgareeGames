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
    
    var navi: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    private let bag = DisposeBag()
    
    init(navi:CustomUINavigationController){
        self.navi = navi
    }
    
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
    
    
    

//
//    @discardableResult
//    func start(viewModel:GuessWhoViewModelRX) -> Completable {
//        let subject = PublishSubject<Never>()
//        // 함수화
//        navigationController.rx.willShow
//            .withUnretained(self)
//            .subscribe(onNext: { coordinator, event in
//                coordinator.navigationController = event.viewController.navigationController! as! CustomUINavigationController
//            })
//            .disposed(by: bag)
//
//        subject.onCompleted()
//        return subject.asCompletable()
//    }

}
