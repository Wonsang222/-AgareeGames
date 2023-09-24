//
//  AuthorizationManager.swift
//  AgareeGames_dis
//
//  Created by 위사모바일 on 2023/07/11.
//

import UIKit
import RxSwift
import Speech
import AVFoundation


class AuthManager{

    static func getMicAuthrization() -> Observable<RXAudioError> {
        return Observable.create { observer in
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    observer.onCompleted()
                } else{
                }
            }
            return Disposables.create()
        }
    }
    
    static func getSpechAuthorization() -> Observable<RXAudioError> {
        return Observable.create { observer in
            SFSpeechRecognizer.requestAuthorization { authStatus in
                switch authStatus {
                case .authorized:
                    observer.onCompleted()
                case .denied,.notDetermined, .restricted :
                    observer.onNext(RXAudioError.SpeechError)
                @unknown default:
                    break
                }
            }
            return Disposables.create()
        }
    }
    
    static func checkMicUsableRX() -> Observable<RXAudioError> {
        return Observable.create { observer in
            let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
            switch micStatus{
            case .authorized:
                observer.onCompleted()
            case .denied, .notDetermined, .restricted:
                observer.onNext(RXAudioError.AudioOff)
            @unknown default:
                break
            }
            return Disposables.create()
        }
    }
    
    static func checkSpeechableRX() -> Observable<RXAudioError> {
        return Observable.create { observer in
            let speechStatus = SFSpeechRecognizer.authorizationStatus()
            switch speechStatus{
            case .authorized:
                observer.onCompleted()
            case .denied, .notDetermined, .restricted:
                observer.onNext(RXAudioError.SpeechAuth)
            @unknown default:
                break
            }
            return Disposables.create()
        }
    }
}
