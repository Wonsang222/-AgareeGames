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
    case pregame(PregameViewModel)
    case test(ResultViewModel)
}

extension Scene{
    func instantiate() -> BaseController{
        switch self{
        case .pregame(let viewmodel):
            var vc = PreGameController()
            DispatchQueue.main.async {
                vc.bind(viewmodel: viewmodel)
            }
            return vc
        case .test(_):
            let vc = ResultController(isWin: true)
            return vc
        }
    }
}
