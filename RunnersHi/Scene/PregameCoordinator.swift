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
    var navi: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    init(navi: CustomUINavigationController) {
        self.navi = navi
    }
    
    @discardableResult
    func start() -> Completable {

        let subject = PublishSubject<Never>()

        let viewModel = PregameViewModel(game: .GuessWho, sceneCoordinator: self)
        var vc = PreGameController()
        DispatchQueue.main.async {
            vc.bind(viewmodel: viewModel)
        }
        navi.setViewControllers([vc], animated: true)
        print(456)
        subject.onCompleted()

        return subject.asCompletable()
    }
    
//    @discardableResult
//    func playGame(viewmodel:GuessWhoViewModelRX) -> Completable{
//        let subject = PublishSubject<Never>()
//        let child = GameCoordinator(navigationController: navi)
//        child.parentCoordinator = self
//        childCoordinators.append(child)
//
//        child.start()
//        subject.onCompleted()
//        return subject.asCompletable()
//    }
    
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
    
    @discardableResult
    func testing() -> Completable{
        let subject = PublishSubject<Never>()
        let child = GameCoordinator(navi: navi)
        child.parentCoordinator = self
        childCoordinators.append(child)
        
        child.start()
        subject.onCompleted()
        return subject.asCompletable()
    }
}

