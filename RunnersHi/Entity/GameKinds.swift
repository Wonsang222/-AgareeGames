//
//  GameKinds.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/08/13.
//

import Foundation
import RxSwift

public enum GameKinds:String{
    case GuessWho = "인물퀴즈"
}

extension GameKinds{
    var gameTitle:String{
        switch self{
        case .GuessWho:
            return self.rawValue
        }
    }
    
    func getObservable() -> Observable<Self>{
        return Observable.create { observer in
            observer.onNext(self)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
