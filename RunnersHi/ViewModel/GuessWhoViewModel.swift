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
    
    private let timeLimit = 5.0
    let timeSubject = PublishSubject<Double>()
    let gameStart:AnyObserver<Void>

    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        let starting = PublishSubject<Void>()
        let loading = PublishSubject<Void>()
        
        gameStart = starting.asObserver()
        
        super.init(game: game, coordinator: coordinator)
        
       starting
            .do(onNext: { _ in
                loading.onNext(())
                print("loader")
//                TimerManager.shared.timerControlelr.accept(true)
//                STTEngineRX.shared.runRecognizer()
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        loading
            .withUnretained(self)
            .flatMap{ viewModel in  viewModel.0.getArray }
            .subscribe(onNext: { [weak self] model in
            
                if let model = model {
                    self?.target.accept(model)
                } else {
                    // nil -> game clear
                    print("game clear")
                    TimerManager.shared.timerControlelr.accept(false)
                }
            })
            .disposed(by: rx.disposeBag)
//
//       STTEngineRX.shared.textRelay
//            .filter { [weak self] text in
//                guard let self  = self,
//                      let value = self.target.value else {
//                    return false
//                }
//                return value.isAnswer(text: text)
//            }
//            .subscribe(onNext: { [weak self] _ in
//                    print("right")
//                STTEngineRX.shared.resetText()
//                loading.onNext(())
//            })
//            .disposed(by: rx.disposeBag)
//        
//        TimerManager.shared.time
//            .withUnretained(self)
//            .filter{ data in
//                if data.1 > data.0.timeLimit {
//                    TimerManager.shared.timerControlelr.accept(false)
//                    return false
//                }
//                return true
//            }
//            .subscribe(onNext: { [weak self] time in
//                self?.timeSubject.onNext(time.1)
//            })
//            .disposed(by: rx.disposeBag)
    }
}


