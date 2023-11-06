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
/*
 1. 서버 통신
 2. 게임 로직 -> 게임시작 -> targets에서 하나씩 pop -> subject로 next -> nil -> 게임승리(페이지 이동)
    timeour (VC) -> error -> 게임패배 (페이지 이동)
 3.
 */

class GameViewModel:BaseViewModel {

    private var targetArr = [GamePlayModel]()
    
    let fetchTargets:AnyObserver<Void>

    let target = BehaviorSubject<GamePlayModel?>(value: nil)
    let errorMessage = BehaviorSubject<Error?>(value: nil)
    
    let bag = DisposeBag()
    
    init(game:PregameModel, coordinator:Coordinator) {
                
        let fetching = PublishSubject<Void>()
        let fetchImages = PublishSubject<Dictionary<String, String>>()
        
        fetchTargets = fetching.asObserver()
        
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
    }
    
    func next() {
        
        // new == nil -> win
        
        
        let new = targetArr.popLast()
        target.onNext(new)
    }
    
    func answerAction() -> Action<String, Void> {
        return Action<String, Void> { [unowned self] input in
            
            let answer = try! self.target.value()!.name
            let submit = input.components(separatedBy: "").joined()
            if answer.contains(submit) {
                
                return self.sceneCoordinator.transition(to: .Test(ResultViewModel(isWin: true)),
                                                        using: .push, animation: true)
                    .asObservable()
                    .map { _ in }
            }
            
            return Observable.
            
        }
    }
    
    
}


