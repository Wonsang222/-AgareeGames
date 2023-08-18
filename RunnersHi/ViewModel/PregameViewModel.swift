//
//  PregameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/12.
//

import UIKit
import RxSwift
import RxCocoa

final class PregameViewModel{
    //MARK: -  INPUT
    let gameModel:BehaviorRelay<PregameModel>
    
    //MARK: - OUTPUT
    let gameTitle:Observable<String>
    lazy var gameInstruction:Observable<GuessWhoHTPV> = {
        return setInstruction(by:gameTitle)
    }()
        
    
    let disposeBag = DisposeBag()
    
    init(game:GameKinds){
        let gameType = Observable.just(game)
        gameTitle = gameType.map{ "\($0.gameTitle)"}
        gameModel = BehaviorRelay(value: PregameModel(gameType: game))
    }
    
    func changePlayers(_ num:Int) {
        let revisionNum = num + 2
        
        gameModel
            .subscribe(onNext: {
                let newModel = PregameModel(origin: $0, num: revisionNum)
                self.gameModel.accept(newModel)
            })
            .disposed(by: disposeBag)
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




