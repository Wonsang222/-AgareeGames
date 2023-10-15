//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift

class AppCoordinator:Coordinator{
    var navi: BaseNavigationController!
    var children = [Coordinator]()
    var window: UIWindow? = nil
    var parent: Coordinator? = nil
    
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
}
