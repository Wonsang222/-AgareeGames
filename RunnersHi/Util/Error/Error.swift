//
//  File.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/24.
//

import Foundation

enum NetworkError:Error{
    case timeout
    case rateLimit
    case notconnected
    case serverError
    case unknown
}

struct MyServerError:Error{
    let statusCode:Int
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}

enum AudioError:Error{
    case audioOff
    case totalAudioError
}

enum EncodingError:Error{
    case etcError
}

class ErrorCollector{
    static let shared = ErrorCollector()
    var errArray = [Error]()
    func flush(){
        errArray = []
    }
    private init() {}
}
