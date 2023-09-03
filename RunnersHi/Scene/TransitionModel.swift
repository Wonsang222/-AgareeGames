//
//  TransitionModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/03.
//

import Foundation

enum TransitionStyle{
    case root
    case push
    case modal
}

enum TransitionError:Error{
    case navigationControllerMissing
    case cannotPop
    case unknown
}
