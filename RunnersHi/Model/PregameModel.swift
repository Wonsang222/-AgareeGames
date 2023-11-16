//
//  PregameModel.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/08/13.
//

import Foundation

struct PregameModel:Networkable{
    let gameType: GameKinds
    var players: Int
    
    init(gameType: GameKinds, players: Int = 2) {
        self.gameType = gameType
        self.players = players
    }
    
    init(origin:Self, num:Int) {
        self = origin
        self.players = num
    }

    func getInstView() -> HowToPlayBaseView{
        switch gameType{
        case .GuessWho:
            return GuessWhoHTPV()
        }
    }
    
    func getParam() -> HttpBaseResource {
        let param = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setPath(self.gameType.gameTitle)
            .setParams("numberOfPlayers", self.players)
            .build()
        return param
    }
}
