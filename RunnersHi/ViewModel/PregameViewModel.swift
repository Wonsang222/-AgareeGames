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
    
    // 여기에 auth 관련 코드 작성 해야함.
    
    /*
     ctr -  appear, button merge  ->
     
     vm -  특정한 something을 실행시킴 -> 각각 조건에 맞게 하고 맞으면 coordinator에서 진행시켜
     */
    
    //MARK: -  INPUT
    
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
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}




