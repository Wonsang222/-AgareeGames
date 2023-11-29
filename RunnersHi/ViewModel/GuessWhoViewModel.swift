//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

// timer - sign , setup photo, stt on

final class GuessWhoViewModel:GameViewModel<GuessWhoPlayModel> {
    
    let aa = 5
    let startGame:AnyObserver<Void>
    
    

    
    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        
        let starting = PublishSubject<Void>()
        let judging = PublishSubject<Void>()
        startGame = starting.asObserver()
        
        super.init(game: game, coordinator: coordinator)
        
        starting
//            .do(onNext: { _ in
//                MyTimer.shared.timerControlelr.accept(true)
//            })
            .flatMap{ STTEngineRX.shared.runRecognizer() }
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        
        judging
            .flatMap{ STTEngineRX.shared.submit }
//            .filter{ $0 }
 
    }
}


