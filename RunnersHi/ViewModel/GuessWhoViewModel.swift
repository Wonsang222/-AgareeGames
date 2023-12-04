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

final class GuessWhoViewModel:GameViewModel<GuessWhoPlayModel> {
    
    let timeLimit = 5.0
    var targetArr = [GuessWhoPlayModel]()
    
    let timeSubject = PublishSubject<Double>()
    
    let gameStart:AnyObserver<Void>

    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        let starting = PublishSubject<Void>()
        gameStart = starting.asObserver()
        
        super.init(game: game, coordinator: coordinator)
        
        let loading = PublishSubject<Void>()
        
        let testGameModel1 = GuessWhoPlayModel(name: "조커", photo: UIImage(resource: .joker))
        let testGameModel2 = GuessWhoPlayModel(name: "민지", photo: UIImage(resource: .minji))
        let testGameModel3 = GuessWhoPlayModel(name: "잡스", photo: UIImage(resource: .jobs))
        targetArr = [testGameModel1,testGameModel2,testGameModel3 ]
        
       starting
            .do(onNext: { _ in
                loading.onNext(())
                TimerManager.shared.timerControlelr.accept(true)
                STTEngineRX.shared.runRecognizer()
            })
            .take(1)
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        // loading만 담당  -> next nil ? 성공
        loading
            .withUnretained(self)
            .map { viewmodel in
                return viewmodel.0.targetArr.popLast()
            }
            .subscribe(onNext: { [weak self] model in
                if let model = model {
                    self?.target.accept(model)
                } else {
                    // nil -> game clear
                    print("game clear")
                    
                }
            })
            .disposed(by: rx.disposeBag)

       STTEngineRX.shared.textRelay
            .filter { [weak self] text in
                guard let self  = self,
                      let value = self.target.value else {
                    return false
                }
                return value.isAnswer(text: text)
            }
            .subscribe(onNext: { [weak self] _ in
                    print("right")
                STTEngineRX.shared.resetText()
                
            })
            .disposed(by: rx.disposeBag)
        
        TimerManager.shared.time
            .withUnretained(self)
            .filter{ data in
                if data.1 > data.0.timeLimit {
                    TimerManager.shared.timerControlelr.accept(false)
                    return false
                }
                return true
            }
            .subscribe(onNext: { [weak self] time in
                
                self?.timeSubject.onNext(time.1)
            })
            .disposed(by: rx.disposeBag)
    }
}


