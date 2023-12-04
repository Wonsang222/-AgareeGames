//
//  File.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/24.
//

import Foundation

// total error enum 을 만들어서 switch @unknown에 대응

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
        case WrongAccess = "잘못된 접근입니다."
        case Unkwown = "알 수없는 에러입니다. \n 잠시 후 다시 시도해주세요."
    }
    
    // timeout은 어떻게 처리되는지
    func getError() -> ErrList{
        switch statusCode{
        case 400:
            return ErrList.RateLimit
        case 500:
            return ErrList.OnUpdated
        case 404, 300 :
            return ErrList.WrongAccess
        default:
            return ErrList.Unkwown
        }
    }
}

enum AudioError: String, Error{
    case AudioOff = "디바이스의 Audio 권한이 부여되지 않았습니다. \n 직접 설정합니다."
    case TotalAudioError = "디바이스의 Audio 에러로 음성 기능을 사용할 수 없습니다."
    case SpeechError = "음성인식 기능오류입니다."
    case SpeechAuth = "음성인식 기능 권한이 설정되지 않았습니다."
}

enum GameError:Error {
    case InGame
}
