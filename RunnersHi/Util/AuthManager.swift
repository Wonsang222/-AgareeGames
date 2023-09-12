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

    static func getMicAuthorization(){
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                self.getSpechAuthorization()
            }
        }
    }
    
    static func getSpechAuthorization(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                break
            case .denied,.notDetermined :
                break
//                self.delegate?.handleError(AudioError.SpeechAuth)
            case .restricted:
//                self.delegate?.handleError(AudioError.SpeechError)
                break
            @unknown default:
                break
            }
        }
    }

    
    static func checkMicUsable() -> Completable{
        return Completable.create { completable in
            let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
            switch micStatus{
            case .authorized:
                completable(.completed)
            case .denied, .notDetermined, .restricted:
                completable(.error(AudioError.AudioOff))
            @unknown default:
                completable(.error(AudioError.TotalAudioError))
            }
            return Disposables.create()
        }
    }

    
    static func checkSpeechable() -> Completable{
        return Completable.create { completable in
            let speechStatus = SFSpeechRecognizer.authorizationStatus()
            switch speechStatus{
            case .authorized:
                completable(.completed)
            case .denied, .notDetermined, .restricted:
                completable(.error(AudioError.SpeechAuth))
            @unknown default:
                completable(.error(AudioError.SpeechError))
            }
            return Disposables.create()
        }
    }
}
