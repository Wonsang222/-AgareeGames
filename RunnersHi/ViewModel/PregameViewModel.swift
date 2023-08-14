//
//  PregameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/12.
//

import UIKit
import RxSwift

/*
 1. gametitle bind  take 1
 2. authmanager
 3. howtoplayview
 4. game start
 5. how many players.
 6. push ( create next viewmodel)  -> coordinator
 */

final class PregameViewModel{
    let disposeBag = DisposeBag()
    // Input
    var gameModel:PublishSubject<PregameModel>
    
    // Output
    let gameTitle:Observable<String>
        
    init(game:GameKinds){
        let fetching = PublishSubject<Void>()
        let modeling = PublishSubject<PregameModel>()
        
        gameModel = modeling
        
        fetching
            .flatMap { game.getObservable()}
            .map { PregameModel(gameType: $0) }
            .subscribe(onNext: modeling.onNext)
            .disposed(by: disposeBag)
        
        gameTitle = modeling
            .map{ $0.gameType.gameTitle}
            .map { "\($0)"}
    }
    
    func changePlayers(_ num:Int) {
        
    }
}



//private func configureHowToPlayView(title:String) -> HowToPlayBaseView? {
//    switch title{
//    case "인물퀴즈":
//        return GuessWhoHTPV()
//    default:
//        break
//    }
//    return nil
//}
