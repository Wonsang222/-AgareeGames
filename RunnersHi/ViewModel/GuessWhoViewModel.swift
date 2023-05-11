//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

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
    private var modelQueue = Queue<GuessWhoDataModel>()
    private var delegate:GuessWhoViewModelDelegate

    var getTargetModel: GuessWhoDataModel?{
        return targetModel
    }
    
    mutating func setDummyModel(){
        let data1 = GuessWhoDataModel(name: "이적", photo: "0.circle", realPhoto: nil)
        let data2 = GuessWhoDataModel(name: "빌게이츠", photo: "1.circle", realPhoto: nil)
        let data3 = GuessWhoDataModel(name: "강호동", photo: "2.circle", realPhoto: nil)
        let data4 = GuessWhoDataModel(name: "스티브잡스", photo: "3.circle", realPhoto: nil)
    
        modelQueue.enqueue(value: data1)
        modelQueue.enqueue(value: data2)
        modelQueue.enqueue(value: data3)
        modelQueue.enqueue(value: data4)
    }
    
    mutating func next(){
        targetModel = modelQueue.dequeue()
    }
    
    init(delegate: GuessWhoViewModelDelegate) {
        self.delegate = delegate
    }
}
