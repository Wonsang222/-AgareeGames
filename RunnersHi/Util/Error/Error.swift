//
//  File.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/24.
//

import Foundation

enum NetworkError:Error{
    case timeout
    case disconnected
    case notconnected
}

enum AudioError:Error{
    case audioOff
    case totalAudioError
}


