//
//  BaseViewModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/03.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel:NSObject{
    let sceneCoordinator:Coordinator
    let errorTrigger:BehaviorSubject<Error?>
//    let storage
    
    init(sceneCoordinator: Coordinator) {
        self.sceneCoordinator = sceneCoordinator
        self.errorTrigger = BehaviorSubject<Error?>(value: nil)
    }
    
    final func handleErrors(error:Error){
        switch error{
        case let audioErr as AudioError:
            handleAudioError(err: audioErr)
        case let serverErr as MyServer.ErrList:
            handleServerErr(err: serverErr)
            // fly io 서버 리부팅에 대한 error 처리
        case is URLError:
            self.alert(message: "현재 서버와 연결이 어렵습니다. \n 잠시 후 다시 시도해주세요.", agree: { alert in
                self.goBackToRoot()
            }, disagree: nil)
        default:
            showAppTerminatingAlert()
            print("😱😱😱😱😱😱😱😱😱😱😱")
        }
    }
    
   final func handleServerErr(err:MyServer.ErrList){
            switch err{
            case .RateLimit:
                alert(message: err.rawValue, agree: { alert in
                    self.goBackToRoot()
                }, disagree: nil)
            case .OnUpdated:
                alert(message: err.rawValue, agree: { alert in
                    self.goBackToRoot()
                }, disagree: nil)
            case .Unkwown:
                alert(message: err.rawValue, agree: { alert in
                    self.goBackToRoot()
                }, disagree: nil)
            case .WrongAccess:
                break
            }
    }
    
    final func handleAudioError(err:AudioError){
        print(err)
        switch err{
        case .TotalAudioError:
            alert(message: err.rawValue) { alert in
                self.goBackToRoot()
            }
        case .AudioOff:
            alert(message: err.rawValue) { alert in
                if let appSetting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSetting)
                }
            }
        case .SpeechAuth:
            alert(message: err.rawValue) { alert in
                if let appSetting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSetting)
                }
            }
        case .SpeechError:
            alert(message: err.rawValue) { alert in
                self.goBackToRoot()
            }
        }
    }
    
    
}
