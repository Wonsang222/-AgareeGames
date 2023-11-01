//
//  GameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 10/31/23.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

/*
 1. 서버 통신
 2. 게임 로직 -> 게임시작 -> targets에서 하나씩 pop -> subject로 next -> nil -> 게임승리(페이지 이동)
    timeour (VC) -> error -> 게임패배 (페이지 이동)
 3.
 */

class GameViewModel<T>:BaseViewModel {

    private var targets = [T]()
    
    let fetchTargets:AnyObserver<Void>
    
    
    
    init(game:PregameModel, coordinator:Coordinator) {
                
        let fetching = PublishSubject<Void>()
        
        
        fetchTargets = fetching.asObserver()
        
        fetching
            .
        
        
        super.init(sceneCoordinator: coordinator)
        
    }
    
}


