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
    
//    private var targetArr = [T]()
    let target:BehaviorRelay<T?> = BehaviorRelay(value: nil)
    
    //    let fetchTargets:AnyObserver<Void>
    //

    init<V:Networkable>(game:V, coordinator:Coordinator) {
        
        //        let fetching = PublishSubject<Void>()
        let fetchImages = PublishSubject<Dictionary<String, String>>()
        let reloading = PublishSubject<Void>()
        
        //        fetchTargets = fetching.asObserver()
        
        super.init(sceneCoordinator: coordinator)
        //
        //        fetching
        //            .do(onNext: { [weak self] _ in
        //                self?.target.accept(testGameModel as? T)
        //            })
        //            .subscribe()
        //            .disposed(by: rx.disposeBag)
        
        
        
        //
        //        fetching
        //            .flatMap{ NetworkService.shared.fetchJsonRX(resource: game.getParam()) }
        //            .do(onError: { [weak self] err in
        //                self?.errorMessage.onNext(err)
        //            })
        //            .subscribe(onNext: { json in
        //                fetchImages.onNext(json)
        //            })
        //            .disposed(by: rx.disposeBag)
        //
        //        fetchImages
        //            .flatMap{ NetworkService.shared.fetchImageRX(source: $0)}
        //            .do(onError: { [weak self] err in
        //                self?.errorMessage.onNext(err)
        //            })
        //            .subscribe(onNext: { [unowned self] targets in
        //                self.targetArr = targets
        //            })
        //            .disposed(by: rx.disposeBag)
        
    }
}
