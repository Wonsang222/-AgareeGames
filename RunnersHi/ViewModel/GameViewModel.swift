//
//  GameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 10/31/23.
//

import Foundation
import RxSwift

class GameViewModel:BaseViewModel {
    
    private var targetArray = [GamePlayModel]()
    let target:BehaviorSubject<GamePlayModel>
    
    init(sceneCoordinator:Coordinator, gameType:PregameModel) {
        
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
    
}


