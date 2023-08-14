//
//  PregameModel.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/08/13.
//

import Foundation

public struct PregameModel:PlayableType{
    let gameType: GameKinds
    var players: Int
    
    init(gameType: GameKinds, players: Int = 0) {
        self.gameType = gameType
        self.players = players
    }
    
    init(origin:Self, updatedPlayers:Int){
        self = origin
        self.players = updatedPlayers
    }
}
