//
//  GuessWhoViewModelRX.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/14.
//

import UIKit
import RxSwift
import RxCocoa

/*
 에러 종류로 분기 -> scene 이동
 
 time 에러 -> 패배
 
 next 에러 -> 승리
 
 
 
 */


class GuessWhoViewModelRX:BaseViewModel{
    
    private var targetArray = [GuessWhoPlayModel]()
    private var targetModel = BehaviorSubject<GuessWhoPlayModel?>(value: nil)
    
    
//    func next() ->  ㄹ {
//        return Completable.create { ob in
//            
//            
//            
//            return Disposables.create()
//        }
//    }
    
    
    
    
}
