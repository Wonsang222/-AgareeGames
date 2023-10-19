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
    var window: UIWindow
    var parent: Coordinator? = nil
    
    var bag:DisposeBag = DisposeBag()
    
    init(window:UIWindow, navi:BaseNavigationController) {
        self.window = window
        self.navi = navi
    }
    
    @discardableResult
    func start() -> Completable{
        let subject = PublishSubject<Never>()
        // start point
        let model = PregameModel(gameType: .GuessWho)
        let child = PregameCoordinator(window: self.window, navi: self.navi, model: model)
        child.parent = self
        self.children.append(child)
        
        let viewModel = PregameViewModel(game: .GuessWho, sceneCoordinator: child)
        let scene = Scene.Pregame(viewModel)
        
        child.transition(to: scene, using: .root, animation: true)
        window.rootViewController = child.navi
        window.makeKeyAndVisible()
    
        subject.onCompleted()
        return subject.asCompletable()
    }
}
