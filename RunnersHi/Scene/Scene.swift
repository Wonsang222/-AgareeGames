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
//    case modal
}

enum Scene{
    
    enum play {
        case pregame(PregameViewModel)
        case guesswho(GuessWhoViewModel)
        case result(ResultViewModel)
    }
    case Play(play)
}

extension Scene{
    
    func instantiate() -> BaseController {
        switch self {
        case .Play(let pp): return setPlayVC(pp)        
        }
    }
    
    private func setPlayVC(_ pr:play) -> BaseController {
        switch pr {
        case .pregame(let vm):
            var vc = PreGameController()
            DispatchQueue.main.async {
                vc.bind(viewmodel: vm)
            }
            return vc
        case .guesswho(let vm):
            var vc = GuessWhoController()
//            DispatchQueue.main.async {
//                vc.bind(viewmodel: vm)
//            }
            return vc
        case .result(let vm):
            var vc = GuessWhoController()
//            DispatchQueue.main.async {
//                vc.bind(viewmodel: vm)
//            }
            return vc
        }
    }
}
