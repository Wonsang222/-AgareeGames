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
    var navigationController: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    private let bag = DisposeBag()
    
    init(navigationController:CustomUINavigationController){
        self.navigationController = navigationController
    }

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
