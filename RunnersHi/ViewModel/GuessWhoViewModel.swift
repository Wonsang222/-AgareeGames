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
                delegate.clearGame(isWin: true)
                return
            }
            delegate.setNextTarget(with: targetModel)
        }
    }
    private var models:[GuessWhoDataModel] = []
    private var delegate:GuessWhoViewModelDelegate

    var getTargetModel: GuessWhoDataModel?{
        return targetModel
    }
    
    mutating func setDummyModel(){
        ["이적", "빌게이츠", "강호동","유재석", "하하", "정준하"].forEach{(element) in
            var int = 0
            let data = GuessWhoDataModel(name: element, photo: "\(0).circle", realPhoto: nil)
            models.append(data)
            int += 1
        }
    }
    
    mutating func next(){
        targetModel = models.popLast()
    }
    
    init(delegate: GuessWhoViewModelDelegate) {
        self.delegate = delegate
    }
}
