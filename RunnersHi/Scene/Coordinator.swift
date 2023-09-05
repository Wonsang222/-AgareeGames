//
//  Coordinatortype.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/09/04.
//

import UIKit

enum Event{
    case buttonTapped
}

protocol Coordinator{
    var navigationController:UINavigationController? { get set }
    
    func start()
    func eventOccured(with type:Event)
}

protocol Coordinating{
    var coordinator:Coordinator? { get set }
    
}
