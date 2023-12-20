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
    
    //MARK: - PROPERTIES
    private var targetArr = [T]()
    //MARK: - INPUT
    let fetchTargets:AnyObserver<Void>
    //MARK: - OUTPUT
    let target:BehaviorRelay<T?> = BehaviorRelay(value: nil)
    
    init<V:Networkable>(game:V, coordinator:Coordinator) {
        
        let fetching = PublishSubject<Void>()
        let reloading = PublishSubject<Void>()
        
        fetchTargets = fetching.asObserver()
        
        super.init(sceneCoordinator: coordinator)
        
        fetching
            .flatMap{ NetworkService.shared.fetchJsonRX(resource: game.getParam()) }
            .do(onError: { [weak self] err in
                self?.errorMessage.onNext(err)
            })
            .flatMap{ json in NetworkService.shared.fetchImageRX(source: json)}
            .do(onError: { [weak self] err in
                self?.errorMessage.onNext(err)
            })
            .subscribe(onNext: { [weak self] targets in
                self?.targetArr = targets
            }, onError: { err in
                print(err.localizedDescription)
            })
            .disposed(by: rx.disposeBag)
    }
    
    lazy var getArray:Observable<T?> = {
        return Observable.create { [weak self] ob in
            ob.onNext(self?.targetArr.popLast())
            return Disposables.create()
        }
    }()
}
