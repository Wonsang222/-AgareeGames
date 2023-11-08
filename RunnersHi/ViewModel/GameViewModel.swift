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

class GameViewModel:BaseViewModel {
    
    private var targetArr = [GamePlayModel]()
    
    let fetchTargets:AnyObserver<Void>
    let loadTarget:PublishRelay<Void>
  
    let target = BehaviorRelay<GamePlayModel?>(value: nil)
    
    let bag = DisposeBag()
    
    init(game:PregameModel, coordinator:Coordinator) {
        
        let fetching = PublishSubject<Void>()
        let fetchImages = PublishSubject<Dictionary<String, String>>()
        
        fetchTargets = fetching.asObserver()
        loadTarget = PublishRelay<Void>()
        
        super.init(sceneCoordinator: coordinator)
        
        fetching
            .flatMap{ NetworkService.shared.fetchJsonRX(resource: game.getParam()) }
            .do(onError: { [weak self] err in
                self?.errorMessage.onNext(err)
            })
            .subscribe(onNext: { json in
                fetchImages.onNext(json)
            })
            .disposed(by: bag)
        
        fetchImages
            .flatMap{ NetworkService.shared.fetchImageRX(source: $0)}
            .do(onError: { [weak self] err in
                self?.errorMessage.onNext(err)
            })
            .subscribe(onNext: { [unowned self] targets in
                self.targetArr = targets
            })
            .disposed(by: bag)
        
        loadTarget
            .subscribe(onNext: { [weak self] _ in
                let next = self?.targetArr.popLast()
                self?.target.accept(next)
            })
            .disposed(by: bag)
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
            return self.sceneCoordinator.transition(to: .Test(ResultViewModel(isWin: isWin)),
                                                    using: .push,
                                                    animation: true)
            .asObservable()
            .map{ _ in }
        }
    }
}
