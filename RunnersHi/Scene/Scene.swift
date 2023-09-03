//
//  Scene.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/23.
//

import UIKit

enum Scene{
    case main(PregameViewModel)
    case game(GuessWhoViewModel)
    case result(ResultViewModel)
    case inst(InstViewModel)
}

extension Scene{
    func instantiate() -> UIViewController{
        
        switch self{
        case .main(let pregameViewmodel):
            var main = PreGameController()
            
            DispatchQueue.main.async {
                main.bind(viewmodel: pregameViewmodel)
            }
            
            let nav = CustomUINavigationController(rootViewController: main)
            return nav
        case .game(let gameViewmodel):
            print(123)
            
        case .result(let resultViewModel):
            print(123)
        case .inst(let instViewModel):
            print(123)
        }
        return UIViewController()
    }
}
