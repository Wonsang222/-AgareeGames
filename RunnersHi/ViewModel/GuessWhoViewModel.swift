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
import Action

// timer - sign , setup photo, stt on

final class GuessWhoViewModel:GameViewModel<GuessWhoPlayModel> {
    private var targetArr = [GuessWhoPlayModel]()
    
    let gameStart:AnyObserver<Void>

    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        let starting = PublishSubject<Void>()
        gameStart = starting.asObserver()
        
        super.init(game: game, coordinator: coordinator)
        
        let loading = PublishSubject<GuessWhoPlayModel?>()
        
        let testGameModel1 = GuessWhoPlayModel(name: "조커", photo: UIImage(resource: .joker))
        let testGameModel2 = GuessWhoPlayModel(name: "민지", photo: UIImage(resource: .minji))
        let testGameModel3 = GuessWhoPlayModel(name: "잡스", photo: UIImage(resource: .jobs))
        targetArr = [testGameModel1,testGameModel2,testGameModel3 ]
        
       starting
            .debug()
            .do(onNext: { [weak self] _ in
                let a = self?.targetArr.popLast()
                loading.onNext(a)
                print(123)
                TimerManager.shared.timerControlelr.accept(true)
//                STTEngineRX.shared.runRecognizer()
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        // loading만 담당  -> next nil ? 성공
        loading
            .flatMap{ [weak self] model -> Completable in
                if let model = model {
                    print(5)
                    self?.target.accept(model)
                    return Completable.empty()
                } else {
                    print("game clear")
                    return Completable.empty()
                }
            }
            .subscribe()
            .disposed(by: rx.disposeBag)
    
        // 맞추면 reset -> 맞출때까지 무한반복 + timeout  -> game over
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
            })
            .disposed(by: rx.disposeBag)
        
        TimerManager.shared.time
            .filter{ [weak self] time in
                    
                return true
            }
            .subscribe(onNext: { [weak self] _ in
                    print("time out")
            })
            .disposed(by: rx.disposeBag)
        
        
        
        
    }
}


