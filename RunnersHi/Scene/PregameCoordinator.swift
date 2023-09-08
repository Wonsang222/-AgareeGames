//
//  PregameCoordinator.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/06.
//

import UIKit
import RxSwift
import RxCocoa

class PregameCoordinator: Coordinator {
    var navigationController: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: CustomUINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> Completable {

        let subject = PublishSubject<Never>()

        let viewModel = PregameViewModel(game: .GuessWho, sceneCoordinator: self)
        var vc = PreGameController()
        DispatchQueue.main.async {
            vc.bind(viewmodel: viewModel)
        }
        navigationController.setViewControllers([vc], animated: false)
        subject.onCompleted()

        return subject.asCompletable()
    }
    
    
//    @discardableResult
//    func start() -> Completable{
//        return Completable.create {[weak self] ob in
//            print(123)
//            let viewModel = PregameViewModel(game: .GuessWho, sceneCoordinator: self!)
//            var vc = PreGameController()
////            DispatchQueue.main.async {
//                vc.bind(viewmodel: viewModel)
////            }
//            self!.navigationController.setViewControllers([vc], animated: false)
//            ob(.completed)
//            return Disposables.create()
//        }
//    }
    
    @discardableResult
    func playGame() -> Completable{
        let subject = PublishSubject<Never>()
        
        return subject.asCompletable()
        
    }

}

