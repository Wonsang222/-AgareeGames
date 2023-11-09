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
    
    enum Preplay {
        case pregame(PregameViewModel)
    }
    
    enum GamePlay {
        case guessWho(GameViewModel)
        case test(ResultViewModel)
    }
    
    case preplay(Preplay)
    case gamePlay(GamePlay)
}

extension Scene{
    func instantiate() -> BaseController {
        switch self {
        case .preplay(let pre): return setPreVC(pre)
        case .gamePlay(let gp): return setGameVC(gp)
        }
        
        
//        switch self {
//        case .Pregame(let viewmodel):
//            var vc = PreGameController()
//            DispatchQueue.main.async {
//                vc.bind(viewmodel: viewmodel)
//            }
//            return vc
//        case .Test(_):
//            let vc = ResultController(isWin: true)
//            return vc
//        case .GuessWho(_):
//            let vc = GuessWhoController()
////            DispatchQueue.main.async {
////                vc.bind(viewmodel: viewmodel)
////            }
//            return vc
//        }
        
    }
    
    private func setPreVC(_ pr:Preplay) -> BaseController {
        switch pr {
        case .pregame(let vm):
            var vc = PreGameController()
            DispatchQueue.main.async {
                vc.bind(viewmodel: vm)
            }
            return vc
        }
    }
    
    private func setGameVC(_ pr:GamePlay) -> BaseController {
        switch pr {
        case .guessWho(let vm):
            var vc = GuessWhoController()
//            DispatchQueue.main.async {
//                vc.bind(viewmodel: vm)
//            }
            return vc
        case .test(let vm):
            var vc = GuessWhoController()
//            DispatchQueue.main.async {
//                vc.bind(viewmodel: vm)
//            }
            return vc
        }
    }
}
