//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import RxSwift
import RxRelay

final class GuessWhoViewModel:GameViewModel<GuessWhoPlayModel> {
    
    let startGame:AnyObserver<Void>
    
    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        
        let starting = PublishSubject<Void>()
        
        startGame = starting.asObserver()
        
        super.init(game: game, coordinator: coordinator)
        
        starting
            .do(onNext: { [unowned self] _ in
                
            })
    }
    
    
    
}


