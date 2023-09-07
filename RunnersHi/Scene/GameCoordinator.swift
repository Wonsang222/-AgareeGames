//
//  GameCoordinator.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/06.
//

import UIKit
import RxSwift

class GameCoordinator: Coordinator {
    var navigationController: CustomUINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    init(navigationController:CustomUINavigationController){
        self.navigationController = navigationController
    }
    
    func start() -> Completable {
        
        let subject = PublishSubject<Never>()
        
        return subject.asCompletable()
    }

}
