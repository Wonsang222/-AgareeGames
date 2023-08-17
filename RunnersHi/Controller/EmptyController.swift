//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit
import RxSwift

class EmptyController:BaseController{
    
    let viewModel = PregameViewModel(game: .GuessWho)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
        
        
        viewModel.gameInstruction
            .subscribe { aa in
                print(aa)
            }
            .disposed(by: DisposeBag())
        
        viewModel.gameInstruction
            .subscribe { aa in
                print(aa)
            }
        
    }
}
