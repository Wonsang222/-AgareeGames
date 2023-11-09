//
//  GameCoordinator.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/06.
//

import UIKit
import RxSwift
import RxCocoa

class GameCoordinator1:Coordinator1 {
    override func start() -> Completable {
        let subject = PublishSubject<Never>()
        
        return subject.asCompletable()
    }
}

class GameCoordinator: Coordinator {

    var navi: BaseNavigationController!
    var children = [Coordinator]()
    weak var parent: Coordinator?
    var window: UIWindow

    var bag = DisposeBag()
    
    required init(window:UIWindow, navi:BaseNavigationController) {
        self.window = window
        self.navi = navi
    }
    
    @discardableResult
    func start() -> Completable {
        
        let subject = PublishSubject<Never>()
        
        return subject.asCompletable()
    }
}
