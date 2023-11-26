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

class GameViewModel<T>:BaseViewModel where T:Playable {
    
    private var targetArr = [T]()
    private let target:BehaviorRelay<T?> = BehaviorRelay(value: nil)
    let fetchTargets:AnyObserver<Void>
    
    var getPhoto:Driver<UIImage> {
        return Observable.create { [weak self] ob in
            if let photo = self?.target.value?.photo {
                ob.onNext(photo)
            } else {
                ob.onNext(UIImage(resource: .joker))
            }
            ob.onCompleted()
            return Disposables.create()
        }.asDriver(onErrorJustReturn: UIImage(resource: .joker))
    }
    
    var getAnswer:Driver<String> {
        return Observable.create { [weak self] ob in
            if let name = self?.target.value?.name {
                ob.onNext(name)
            } else {
                ob.onNext("")
            }
            ob.onCompleted()
            return Disposables.create()
        }.asDriver(onErrorJustReturn: "")
    }
    
    // output
    
    init<V:Networkable>(game:V, coordinator:Coordinator) {
        
        let fetching = PublishSubject<Void>()
        let fetchImages = PublishSubject<Dictionary<String, String>>()
        let reloading = PublishSubject<Void>()
    
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

    }
    
//    private func answerAction() -> Action<String, Void> {
//        return Action<String, Void> { [unowned self] input in
//            
//            
//     
//            
//            guard let answer = self.target.value?.name else {
//                errorMessage.onNext(GameError.InGame)
//                return .empty()
//            }
//                
//            let submit = input.components(separatedBy: "").joined()
// 
//            guard answer.contains(submit) else {
//                return Observable.just(())
//            }
//            
//            loadTarget.accept(())
//            return Observable.just(())
//        }
//    }
    
//    private func judgeAction(isWin:Bool) -> Action<Void, Void> {
//        
//        return Action<Void, Void> { [unowned self] _ in
//            let viewModel = ResultViewModel(isWin: true, sc: self.sceneCoordinator)
//            let nextScene:Scene = .Play(.result(viewModel))
//            return sceneCoordinator.transition(to: nextScene
//                                               , using: .push
//                                               , animation: true)
//            .asObservable()
//            .map { _ in } 
//        }
//    }
}
