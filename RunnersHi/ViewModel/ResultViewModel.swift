//
//  ResultViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/02.
//

import Foundation
import RxSwift
import RxCocoa
import Action


// navi barbutton left -> hide and replace custom bar button
final class ResultViewModel:BaseViewModel {
    var isWin:Bool
    
    
    
    init(isWin: Bool, sc:Coordinator) {
        self.isWin = isWin
        super.init(sceneCoordinator: sc)
    }
    
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true)
            .asObservable()
            .map { _ in }
        
    }
    

}
