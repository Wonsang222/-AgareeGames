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
    
    override init<V>(game: V, coordinator: Coordinator) where V : Networkable {
        
        super.init(game: game, coordinator: coordinator)
    }
    
}


