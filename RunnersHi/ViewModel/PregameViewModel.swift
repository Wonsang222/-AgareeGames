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

import AVFoundation
import Speech

final class PregameViewModel:BaseViewModel{
    
    //MARK: -  INPUT
    private lazy var authManager = AuthManager()
//    let playAction:Action<PregameModel, Void>
    
    lazy var updateModel:(Int) -> Void = { [weak self] num in
        if var currentModel = try? self?.gameModel.value(){
            let convertedNum = num + 2
            let updatedModel = currentModel.changePlayer(convertedNum)
            self?.gameModel.onNext(updatedModel)
        }
    }
    
    //MARK: - OUTPUT
    let gameModel:BehaviorSubject<PregameModel>
    let gameTitle:Single<String>
    let gameInst:Single<HowToPlayBaseView>
    
    init(game:GameKinds, sceneCoordinator:Coordinator){
        let baseModel = PregameModel(gameType: game)
        gameModel = BehaviorSubject(value: baseModel)
        self.gameTitle = Observable.just(baseModel.gameType.gameTitle).asSingle()
        self.gameInst = Observable.just(baseModel.getInstView()).asSingle()
        
//        self.playAction = Action <PregameModel, Void> { input in
//
//            return sceneCoordinator.close(animated: true)
//                .asObservable()
//                .map{ _  in }
//        }
        super.init(sceneCoordinator: sceneCoordinator)
    }
        
    private func setGameController() -> Observable<GuessWhoController>{
        return Observable.create { emitter in
            emitter.onNext(GuessWhoController())
            return Disposables.create()
        }
    }
}




