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
    
    let startGame:AnyObserver<Void>
    
    private var targetArr = [GuessWhoPlayModel]()

    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        
        let starting = PublishSubject<Void>()
        let judging = PublishSubject<Void>()

        startGame = starting.asObserver()
        
        super.init(game: game, coordinator: coordinator)

        let fetching = PublishSubject <Void>()
        let testGameModel1 = GuessWhoPlayModel(name: "조커", photo: UIImage(resource: .joker))
        let testGameModel2 = GuessWhoPlayModel(name: "민지", photo: UIImage(resource: .minji))
        let testGameModel3 = GuessWhoPlayModel(name: "잡스", photo: UIImage(resource: .jobs))
        
        
        
        starting
        //            .do(onNext: { _ in
        //                MyTimer.shared.timerControlelr.accept(true)
        //            })
            .flatMap{ STTEngineRX.shared.runRecognizer() }
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        
        judging
            .flatMap{ STTEngineRX.shared.textRelay }
        //            .filter{ $0 }
        
        
        fetching
            .do(onNext: { _ in
                    targetArr = [testGameModel1, testGameModel2, testGameModel3]
            })
            
        
            
        
        
    }
}


