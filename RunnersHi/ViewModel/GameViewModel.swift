//
//  GameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 10/31/23.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

// fetching + start

class GameViewModel:BaseViewModel {
    
    private var targetArr = [GamePlayModel]()
    
    let fetchTargets:AnyObserver<Void>
    let startGame:AnyObserver<Void>
    let loadTarget:PublishRelay<Void>
    
    private let repeater:Observable<Void>
    
    // output
    let target = BehaviorRelay<GamePlayModel?>(value: nil)
    let timer:PublishSubject<Double>
    
    init(game:PregameModel, coordinator:Coordinator) {
        
        let fetching = PublishSubject<Void>()
        let fetchImages = PublishSubject<Dictionary<String, String>>()
        let starting = PublishSubject<Void>()
        let answer = PublishSubject<String>()
        let reloading = PublishSubject<Void>()
    
        fetchTargets = fetching.asObserver()
        startGame = starting.asObserver()
        loadTarget = PublishRelay<Void>()
        timer = PublishSubject<Double>()
        repeater = Observable<Int>.interval(.milliseconds(20),
                                            scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .map{ _ in 0.02 }
            .scan(0.0, accumulator: { total, newValue in
                    return total + newValue
            })
            .withUnretained(self)
            .flatMap{ viewmodel,total -> Observable<Void> in
                if total > 5.0 {
                    viewmodel.judgeAction(isWin: false)
                    return .empty()
                } else {
                    viewmodel.timer.onNext(total)
                    return .empty()
                }
            }
        

        super.init(sceneCoordinator: coordinator)
        
        fetching
            .flatMap{ NetworkService.shared.fetchJsonRX(resource: game.getParam()) }
            .do(onError: { [weak self] err in
                self?.errorMessage.onNext(err)
            })
            .subscribe(onNext: { json in
                fetchImages.onNext(json)
            })
            .disposed(by: rx.disposeBag)
        
        fetchImages
            .flatMap{ NetworkService.shared.fetchImageRX(source: $0)}
            .do(onError: { [weak self] err in
                self?.errorMessage.onNext(err)
            })
            .subscribe(onNext: { [unowned self] targets in
                self.targetArr = targets
            })
            .disposed(by: rx.disposeBag)
        
        loadTarget
            .withUnretained(self)
            .do(onNext: { viewmodel, _ in
                // 리피터를 연결 끊고 다시 시작
                
            })
            .
        
        // timer + loadTarget + STT?   -> 에러 메세지 체크 프로세스
        starting
            .do(onNext: { [weak self] _ in
                
            })
            .withUnretained(self)
            .flatMap{ vm, _ in vm.repeater }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] second in
                self?.timer.onNext(second)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func answerAction() -> Action<String, Void> {
        return Action<String, Void> { [unowned self] input in
            
            guard let answer = self.target.value?.name else {
                errorMessage.onNext(GameError.InGame)
                return .empty()
            }
                
            let submit = input.components(separatedBy: "").joined()
 
            guard answer.contains(submit) else {
                return Observable.just(())
            }
            
            loadTarget.accept(())
            return Observable.just(())
        }
    }
    
    func judgeAction(isWin:Bool) -> Action<Void, Void> {
        
        return Action<Void, Void> { [unowned self] _ in
            let viewModel = ResultViewModel(isWin: true, sc: self.sceneCoordinator)
            let nextScene:Scene = .Play(.result(viewModel))
            return sceneCoordinator.transition(to: nextScene
                                               , using: .push
                                               , animation: true)
            .asObservable()
            .map { _ in } 
        }
    }
}
