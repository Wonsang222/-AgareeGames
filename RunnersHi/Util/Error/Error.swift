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
    enum ErrList: String,Error {
        case RateLimit = "잦은 시도는 서버에 무리를 줄 수 있습니다. \n 1분 후에 다시 시도해주세요."
        case OnUpdated = "서버 점검 중입니다. \n 잠시 후 다시 시도해주세요."
        case Unkwown = "알 수없는 에러입니다. \n 잠시 후 다시 시도해주세요."
    }
    
    // timeout은 어떻게 처리되는지
    func emitError() -> ErrList{
        switch statusCode{
        case 400:
            return ErrList.RateLimit

        case 503:
            return ErrList.OnUpdated
        default:
            return ErrList.Unkwown
        }
    }
}
// talkgamecontroller 시작할대, audio 기능 off면 이거 ㅋ야함.
// 테스트 해야함
enum AudioError: String, Error{
    case audioOff = "디바이스의 Audio기능을 사용할 수 없습니다. \n 설정에서 처리해야하나, 자동적으로 물어보나 go back "
    case totalAudioError = "디바이스의 Audio 에러로 음성 기능을 사용할 수 없습니다."
}

