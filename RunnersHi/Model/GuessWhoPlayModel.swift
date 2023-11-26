//
//  GuessWhoPlayModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/21.
//
import UIKit
import RxSwift


struct GuessWhoPlayModel:Playable {
    let name:String
    var photo:UIImage?
    
    init(name:String, photo:UIImage? = nil){
        self.name = name
        self.photo = photo
    }
    
    func matchAnswer(submission:String) -> Observable<Bool> {
        return Observable.create { ob in
            let sub = submission.components(separatedBy: " ").joined()
            if sub.contains(self.name) {
                ob.onNext(true)
            } else  {
                ob.onNext(false)
            }
            ob.onCompleted()
            return Disposables.create()
        }
    }
}




