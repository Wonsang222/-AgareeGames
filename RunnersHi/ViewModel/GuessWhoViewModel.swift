//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//


/*
 만약 에러가 나지 않은 상태에서
 게임 시작 준비가 되었는데, 네트워크 연결이 아직 안된 상태라면
 error처리해야하는디
 */

import UIKit

protocol GuessWhoViewModelDelegate:BaseDelegate{
    func setNextTarget(with data:GuessWhoPlayModel)
    func clearGame(isWin:Bool)
    // 에러 핸들링
}

class GuessWhoViewModel{
    
    var isNetworkDone:Bool = false
    private var delegate:GuessWhoViewModelDelegate
    var playModelArray:[GuessWhoPlayModel] = []
    
    
    private var targetModel:GuessWhoPlayModel?{
        didSet{
            guard let targetModel = targetModel else {
                // 게임 이긴 경우
                delegate.clearGame(isWin: true)
                return
            }
            delegate.setNextTarget(with: targetModel)
        }
    }
    
    var getTargetModel: GuessWhoPlayModel?{
        return targetModel
    }
    
    func next(){
        targetModel = playModelArray.popLast()
    }
    
    init(delegate: GuessWhoViewModelDelegate) {
        self.delegate = delegate
        
    }
    
    func fetchNetworkData(httpbaseResource:HttpBaseResource){
        Task{
            do{
                playModelArray = []
                let jsonData = await NetworkService.fetchJSON(httpbaseresource: httpbaseResource)
                guard let jsonData = jsonData else { throw NetworkError.serverError }
                let array = await NetworkService.fetchImage(jsonData)
                playModelArray = array
                isNetworkDone = true
                if let delegate = delegate as? GameController, await delegate.loader.isAnimating{
                    await delegate.loaderOFF()
                }
                Task{
                    //                    saveDB()
                }
            } catch{
                delegate.handleError(error)
            }
        }
    }
    
    func saveDB() {
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self = self else { return }
            for model in self.playModelArray{
                let targetUrl = Global.PHOTODBURL.appendingPathComponent(model.name).appendingPathExtension("json")
                do{
                    let isExisted = try targetUrl.checkResourceIsReachable()
                    if !isExisted{
                        let encoder = JSONEncoder()
                        let data = try encoder.encode(model)
                        try data.write(to: targetUrl)
                    }else{
                     continue
                    }
                } catch{
                    print(error)
                }
            }
        }
    }
    
    func createResultViewModel() -> ResultViewModel{
        
        return ResultViewModel()
    }
}


