//
//  Timer.swift
//  AgareeGames
//
//  Created by 위사모바일 on 11/16/23.
//

import Foundation
import RxSwift

class Timer {
    
    static let shared = Timer()
    let time = PublishSubject<Double>()
    let bag = DisposeBag()
    
    lazy var repeater:Observable<Void> = {
       let repeater = Observable<Int>.interval(.milliseconds(20),
                                               scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
                  .map{ _ in 0.02 }
                  .scan(0, accumulator: { total, newValue in
                          return total + newValue
                  })
                  .withUnretained(self)
                  .flatMap{ timer,total -> Observable<Void> in
                      if total > Global.GAMESEC {
                          timer.flag.onNext(false)
                          return .empty()
                      }
                      timer.time.onNext(total)
                      return .empty()
                  }
                  .take(until: flag.filter({!$0}))
        return repeater
    }()
    
    lazy var flag:BehaviorSubject<Bool> =  { [unowned self] in
       let sub = BehaviorSubject<Bool>(value: false)
        sub
            .filter{$0}
            .flatMap{ _ in self.repeater }
            .subscribe(onNext: { _ in })
            .disposed(by: self.bag )
        
        return sub
    }()

    private init() {}
}
