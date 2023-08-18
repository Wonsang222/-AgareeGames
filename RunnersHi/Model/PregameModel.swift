//
//  PregameModel.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/08/13.
//

import Foundation

struct PregameModel:PlayableType{
    let gameType: GameKinds
    var players: Int
    
    init(gameType: GameKinds, players: Int = 2) {
        self.gameType = gameType
        self.players = players
    }
    
    mutating func changePlayer(_ num:Int){
        self.players = num
    }
    
    init(origin:Self, num:Int){
        self = origin
        self.players = num
    }
}
