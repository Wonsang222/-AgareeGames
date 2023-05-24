//
//  File.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/24.
//

import Foundation


class AgareeGameError{
    
    enum Network:Error{
        case timeout
        case disconnected
        case notconnected
    }
    
    enum Audio:Error{
        case audioOff
        case totalAudioError
    }
    
    
}

