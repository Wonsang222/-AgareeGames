//
//  PregameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/12.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

final class PregameViewModel:BaseViewModel {
    
    //MARK: -  INPUT
    // Action 으로 교체
    lazy var updateModel:(Int) -> Void = { [weak self] num in
        if var currentModel = try? self?.gameModel.value() {
            let convertedNum = num + 2
            let updatedModel = PregameModel(origin: currentModel, num: convertedNum)
            self?.gameModel.onNext(updatedModel)
        }
    }
    
    //MARK: - OUTPUT
    let gameModel:BehaviorSubject<PregameModel>
    let gameTitle:Single<String>
    let gameInst:Single<HowToPlayBaseView>
    let permissions:Observable<AudioError> = {
        return Observable.concat([AuthManager.getMicAuth(),
                                  AuthManager.getRecordAuth(),
                                     AuthManager.getSpeechAuth()])
    }()
    
    init(game:GameKinds, sceneCoordinator:Coordinator) {
        
        let baseModel = PregameModel(gameType: game)
        gameModel = BehaviorSubject(value: baseModel)
        self.gameTitle = Observable.just(baseModel.gameType.gameTitle).asSingle()
        self.gameInst = Observable.just(baseModel.getInstView()).asSingle()
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}




