//
//  MainCoordinator.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit
import RxSwift

class AppCoordinator:Coordinator{
    var navi: CustomUINavigationController!
    var child = [Coordinator]()
    let window: UIWindow
    var parent: Coordinator? = nil
    
    var bag:DisposeBag = DisposeBag()
    
    init(window:UIWindow) {
        self.window = window
    }
    
    @discardableResult
    func start(children:Coordinator) -> Completable{
        let subject = PublishSubject<Never>()
        children.navi = self.navi
        children.parent = self
        self.child.append(children)
        window.rootViewController = children.navi
        window.makeKeyAndVisible()
        children.transition(to: <#T##Scene#>, using: .root, animation: true)
        subject.onCompleted()
        return subject.asCompletable()
    }
}
