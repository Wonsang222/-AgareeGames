//
//  Scene.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/08/23.
//

import UIKit

enum Scene{
    case main(PregameViewModel)
    case game(GuessWhoViewModel)
//    case result()
}

extension Scene{
    func instantiate() -> NSObject{
        
        switch self{
        case .main(let pregameViewmodel):
            let main = PreGameController(viewModel: pregameViewmodel)
            let nav = CustomUINavigationController(rootViewController: main)
            return nav
        case .game(let gameViewmodel):
            print(123)
        
            
        }
        return UIViewController()
    }
}
