//
//  Protocol.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/23.
//

import Foundation

@objc protocol TimerUsable{
    var timer:Timer? { get }
    var numToCount:Float { get }
    var speed:Float { get }
    @objc func startGameTimer(_ timer:Timer)
}

protocol STTEngineUsable{
    var engine:STTEngine? { get }
    func runRecognizer()
}
