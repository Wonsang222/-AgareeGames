//
//  GuessWhoViewModel.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

class GuessWhoViewModel{
    
    var targetModel:GuessWhoDataModel? = nil
    
    var models:[GuessWhoDataModel]!{
        didSet{
            
        }
    }
    
    func setDummyModel(){
        ["이적", "빌게이츠", "강호동","유재석", "하하", "정준하"].forEach{(element) in
            let data = GuessWhoDataModel(name: element, photo: nil, realPhoto: nil)
            models.append(data)
        }
    }
}
