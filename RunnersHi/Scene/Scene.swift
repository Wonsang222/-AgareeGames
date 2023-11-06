//
//  Scene.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/26.
//

import Foundation

enum TransitionStyle{
    case push
    case back
    case root
}

enum Scene{
    case Pregame(PregameViewModel)
    case Test(ResultViewModel)
    case GuessWho(GameViewModel)
}

extension Scene{
    func instantiate() -> BaseController {
        switch self {
        case .Pregame(let viewmodel):
            var vc = PreGameController()
            DispatchQueue.main.async {
                vc.bind(viewmodel: viewmodel)
            }
            return vc
        case .Test(_):
            let vc = ResultController(isWin: true)
            return vc
        case .GuessWho(_):
            let vc = GuessWhoController()
//            DispatchQueue.main.async {
//                vc.bind(viewmodel: viewmodel)
//            }
            return vc
        }
    }
}
