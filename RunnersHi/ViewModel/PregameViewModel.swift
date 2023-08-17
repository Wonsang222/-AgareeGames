//
//  PregameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/12.
//

import UIKit
import RxSwift


final class PregameViewModel{
    let gameModel:Observable<PregameModel>
    let gameTitle:Observable<String>
    lazy var gameInstruction:Observable<GuessWhoHTPV> = {
        return setInstruction(by:gameTitle)
    }()
        
    init(game:GameKinds){
        let gameType = Observable.just(game)
        gameTitle = gameType.map{ "\($0.gameTitle)"}
        gameModel = gameType.map {PregameModel(gameType: $0)}
    }
    
    func changePlayers(_ num:Int) {
        
    }
    
    private func setInstruction(by observable:Observable<String>) -> Observable<GuessWhoHTPV> {
        return observable.flatMap { title in
            switch title {
            case "인물퀴즈":
                return Observable.just(GuessWhoHTPV())
            default:
                return Observable.empty()
            }
        }
    }
    
}




