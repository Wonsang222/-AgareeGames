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
    
    // INPUT
    var gameTitle:AnyObserver<GameKinds>
    
    // OUTPUT
    
    
    
    private func configureHowToPlayView(title:String) -> HowToPlayBaseView? {
        switch title{
        case "인물퀴즈":
            return GuessWhoHTPV()
        default:
            break
        }
        return nil
    }
    
    init(game:PlayableType){
        let fetching = PublishSubject<Void>()
        
        fetching
            .flatMap { _ in
                return Observable.create { emitter in
                    emitter.onNext(game)
                    return Disposables.create()
                }
            }
            .
    }
    
}
