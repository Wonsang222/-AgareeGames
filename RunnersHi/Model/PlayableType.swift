//
//  PlayableType.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/08/13.
//

import Foundation

protocol PlayableType{
    var gameType:GameKinds { get }
    var players:Int { get }
}
