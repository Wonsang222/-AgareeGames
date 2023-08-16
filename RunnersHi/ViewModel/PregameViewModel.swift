//
//  PregameViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/12.
//

import UIKit
import RxSwift


final class PregameViewModel{
    private let disposeBag = DisposeBag()
    // Input
    private let gameModel:PublishSubject<PregameModel>
    
    // Output
    let gameTitle:Observable<String>
//    let howToPlayView:Observable<GuessWhoHTPV>
        
    init(game:GameKinds){
        let fetching = PublishSubject<Void>()
        let modeling = PublishSubject<PregameModel>()
        
        gameModel = modeling
        
        _ = fetching
            .flatMap { game.getObservable()}
            .map { PregameModel(gameType: $0) }
            .subscribe(onNext: modeling.onNext)
            .disposed(by: disposeBag)
        
        gameTitle = modeling
            .map{ $0.gameType.gameTitle}
            .map { "\($0)"}
        
    }
    
    func changePlayers(_ num:Int) {
        
    }
    
    private func configureHowToPlayView(title:String) -> Observable<GuessWhoHTPV>? {
        switch title{
        case "인물퀴즈":
            return Observable.create { emitter in
                emitter.onNext(GuessWhoHTPV())
                emitter.onCompleted()
                return Disposables.create()
            }
        default:
            break
        }
        return nil
    }
}




