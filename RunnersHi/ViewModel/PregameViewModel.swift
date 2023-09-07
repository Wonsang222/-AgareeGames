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

final class PregameViewModel:BaseViewModel{
    //MARK: -  INPUT
    let gameModel:BehaviorRelay<PregameModel>
//    let playAction:Action<PregameModel, Void>
//    let changePlayerAction:Action<Int, Void>
    
    //MARK: - OUTPUT
    let gameTitle:Single<String>
//    let gameInst:Driver<GuessWhoHTPV>
    
    lazy var gameInstruction:Single<GuessWhoHTPV> = {
        return setInstruction()
    }()

    init(game:GameKinds, sceneCoordinator:Coordinator){
        let baseModel = PregameModel(gameType: game)
        gameModel = BehaviorRelay(value: baseModel)
        self.gameTitle = Observable.just(baseModel.gameType.gameTitle).asSingle()
        
        
//        bindInputs()
//        self.playAction = Action <PregameModel, Void> { input in
//
//            return sceneCoordinator.close(animated: true)
//                .asObservable()
//                .map{ _  in }
//        }
        
//        self.changePlayerAction = Action < Int, Void> { input in
//            
//            return sceneCoordinator.close(animated: true)
//                .asObservable()
//                .map{_ in }
//        }
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
    
    
    private func changePlayers(_ num:Int, _ model:PregameModel) -> PregameModel {
        let revisionNum = num + 2
        return PregameModel(origin: model, num: revisionNum)
    }
    
    private func setInstruction() -> Single<GuessWhoHTPV> {
        return Single.create { [weak self] single in
            let gameType = self?.gameModel.value.gameType
            
            switch gameType{
            case .GuessWho:
                single(.success(GuessWhoHTPV()))
            default:
                single(.failure(NSError(domain: "Test", code: 11)))
            }
            return Disposables.create()
        }
    }
        
    private func setGameController() -> Observable<GuessWhoController>{
        return Observable.create { emitter in
            emitter.onNext(GuessWhoController())
            return Disposables.create()
        }
    }
}




