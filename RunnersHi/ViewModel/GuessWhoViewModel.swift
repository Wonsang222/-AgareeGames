//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

// 고민 - 굳이 델리게이트 패턴을써야할까.. 재사용성을 높일 수 있는 방법은 많은데..  굳이 swifty하게 해야하나.. rx적용할때 ..


protocol GuessWhoViewModelDelegate{
    func setNextTarget(with data:GuessWhoDataModel)
    func clearGame(isWin:Bool)
}

struct GuessWhoViewModel{
    
    private var targetModel:GuessWhoDataModel?{
        didSet{
            guard let targetModel = targetModel else {
                // 게임 이긴 경우
                print(5.5)
                delegate.clearGame(isWin: true)
                return
            }
            print(targetModel)
            print(6.5)
            delegate.setNextTarget(with: targetModel)
           
        }
    }
     var models:[GuessWhoDataModel] = []
    private var delegate:GuessWhoViewModelDelegate

    var getTargetModel: GuessWhoDataModel?{
        return targetModel
    }
    
    mutating func setDummyModel(){
        let data1 = GuessWhoDataModel(name: "이적", photo: "0.circle", realPhoto: nil)
        let data2 = GuessWhoDataModel(name: "빌게이츠", photo: "1.circle", realPhoto: nil)
        let data3 = GuessWhoDataModel(name: "강호동", photo: "2.circle", realPhoto: nil)
        let data4 = GuessWhoDataModel(name: "스티브잡스", photo: "3.circle", realPhoto: nil)
        
        models.append(data1)
        models.append(data2)
        models.append(data3)
        models.append(data4)
    }
    
    mutating func next(){
        targetModel = models.popLast()
    }
    
    init(delegate: GuessWhoViewModelDelegate) {
        self.delegate = delegate
    }
}
