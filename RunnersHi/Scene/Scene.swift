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
    func instantiate() -> BaseController{
        
        switch self{
        case .game(let gameViewmodel):
            print(123)
        case .main(let pregameViewmodel):
            print(123)
        }
        return BaseController()
    }
}
