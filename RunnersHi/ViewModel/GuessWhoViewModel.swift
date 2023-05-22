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
    // 에러 핸들링
    
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
    private var modelArray:[GuessWhoDataModel] = []
    private var playModelArray:[GuessWhoPlayModel] = []
    private var delegate:GuessWhoViewModelDelegate

    var getTargetModel: GuessWhoDataModel?{
        return targetModel
    }
    
    mutating func setOneModel(){
        let data = GuessWhoDataModel(name: "강호동", photo: "2.circle")
        modelArray.append(data)
        
    }
    
    mutating func setDummyModel(){
        let data1 = GuessWhoDataModel(name: "이적", photo: "0.circle")
        let data2 = GuessWhoDataModel(name: "빌게이츠", photo: "1.circle")
        let data3 = GuessWhoDataModel(name: "강호동", photo: "2.circle")
        let data4 = GuessWhoDataModel(name: "스티브잡스", photo: "3.circle")
        
        modelArray.append(data1)
        modelArray.append(data2)
        modelArray.append(data3)
        modelArray.append(data4)

    }
    
    mutating func next(){
//        targetModel = modelArray.popLast()
        targetModel = GuessWhoDataModel(name: "빌게이츠", photo: "2.circle")
    }
    
    init(delegate: GuessWhoViewModelDelegate) {
        self.delegate = delegate
    }
    
    mutating func fetchDummyNetworkData(httpbaseResource:HttpBaseResource)async throws{
        playModelArray = []
        do{
            let jsonData = try await NetworkService.fetchJSON(httpbaseresource: httpbaseResource, controller: delegate as! BaseController)
            let array = try await NetworkService.fetchImage(jsonData)
            playModelArray = array
        } catch{
            
        }

    }
}
