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
    let target = BehaviorRelay<GamePlayModel?>(value: nil)
    let timer:PublishSubject<Double>
    
    let repeater:Observable<Double>
    
    init(game:PregameModel, coordinator:Coordinator) {
        
        let fetching = PublishSubject<Void>()
        let fetchImages = PublishSubject<Dictionary<String, String>>()
        let starting = PublishSubject<Void>()
        let answer = PublishSubject<String>()
    
        fetchTargets = fetching.asObserver()
        startGame = starting.asObserver()
        loadTarget = PublishRelay<Void>()
        timer = PublishSubject<Double>()
        repeater = Observable<Int>.interval(.milliseconds(20), scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .map{ _ in 0.02 }
            .scan(0, accumulator: +)
        
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
            .subscribe(onNext: { [weak self] _ in
                let next = self?.targetArr.popLast()
                self?.target.accept(next)
            })
            .disposed(by: rx.disposeBag)
        
        // timer + loadTarget + STT?
        starting
            .do(onNext: { [weak self] _ in
                
            })
            .flatMap{ [unowned self] in self.repeater }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] second in
                self?.timer.onNext(second)
            })
            .disposed(by: rx.disposeBag)
     
    }
    
    func answerAction() -> Action<String, Void> {
        return Action<String, Void> { [unowned self] input in
            
            let next = targetArr.popLast()
            let answer = self.target.value!.name
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
