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

struct MyServer{
    let statusCode:Int
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
    enum ErrList:Error{
        case Timeout
        case RateLimit
        case closed
        case OnUpdated
        case Unkwown
    }
    
    // timeout은 어떻게 처리되는지
    func emitError() -> ErrList{
        switch statusCode{
        case 400:
            return ErrList.RateLimit
        case 408:
            return ErrList.Timeout
        case 503:
            return ErrList.OnUpdated
        default:
            return ErrList.Unkwown
        }
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
