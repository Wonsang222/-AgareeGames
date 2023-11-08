//
//  PregameCoordinator.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/06.
//

import UIKit
import RxSwift
import RxCocoa


class PregameCoordinator1:Coordinator1 {
    
    override func start() -> Completable {
        let sub = PublishSubject<Never>()
        
        return sub.asCompletable()
    }
}

class PregameCoordinator: Coordinator {
    
    var navi: BaseNavigationController!
    var children = [Coordinator]()
    weak var parent: Coordinator?
    var window: UIWindow
    let model:PregameModel
    
    var bag:DisposeBag = DisposeBag()
    
    init(window:UIWindow, navi:BaseNavigationController, model:PregameModel) {
        self.window = window
        self.navi = navi
        self.model = model
    }
    
    @discardableResult
    func start(child:Coordinator) -> Completable{
        let subject = PublishSubject<Never>()
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
    // 여기서 뭔가를 넣어줘야 올바른 실행이 될듯 viewmodel으로 분기 아니지 게임 타입으로
    func play() -> Completable{
        let subject = PublishSubject<Never>()
        let child = GameCoordinator(window: self.window, navi: self.navi)
        child.parent = self
        children.append(child)
        child.start()
        subject.onCompleted()
        return subject.asCompletable()
    }
}

