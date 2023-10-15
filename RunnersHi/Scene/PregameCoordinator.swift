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
    
    var navi: BaseNavigationController!
    var children = [Coordinator]()
    weak var parent: Coordinator?
    var window: UIWindow? = nil

    var bag:DisposeBag = DisposeBag()
    
    required init(window:UIWindow, navi:BaseNavigationController) {
        self.window = window
        self.navi = navi
    }
    
    @discardableResult
    func start(child:Coordinator) -> Completable{
        let subject = PublishSubject<Never>()
        child.parent = self
        self.children.append(child)
        
        let viewModel = PregameViewModel(game: .GuessWho, sceneCoordinator: child)
        let scene = Scene.pregame(viewModel)
        
        child.transition(to: scene, using: .root, animation: true)
        window?.rootViewController = child.navi
        window?.makeKeyAndVisible()
    
        subject.onCompleted()
        return subject.asCompletable()
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
        subject.onCompleted()
        return subject.asCompletable()
    }
    
    @discardableResult
    func testing() -> Completable{
        let subject = PublishSubject<Never>()
//        let child = GameCoordinator(navi: navi)
//        child.parentCoordinator = self
//        child.append(child)
//        
//        child.start()
        subject.onCompleted()
        return subject.asCompletable()
    }
}

