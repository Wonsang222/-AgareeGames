//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import RxSwift
import RxRelay

final class GuessWhoViewModel{
    
    var networkErr:Error?
    var isNetworkDone:Bool = false
    private var playModelArray:[GuessWhoPlayModel] = []
    
    private var targetModel:GuessWhoPlayModel?{
        didSet{
            guard let targetModel = targetModel else {
                // 게임 이긴 경우 -> targetModel이 nil
                
                return
            }
            
        }
    }
    
    var getTargetModel: GuessWhoPlayModel?{
        return targetModel
    }
    
    func next(){
        targetModel = playModelArray.popLast()
    }

    func fetchNetworkData(httpbaseResource:HttpBaseResource){
        Task{
            do{
                playModelArray = []
                let jsonData = try await NetworkService.fetchJSON(httpbaseresource: httpbaseResource)
                print(jsonData)
                let array = await NetworkService.fetchImage(jsonData)
                playModelArray = array
                isNetworkDone = true
                Task(priority: .low){
                    //                    saveDB()
                }
            } catch{
                networkErr = error
            }
        }
    }
    
    // CoreData로 교체
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
}


