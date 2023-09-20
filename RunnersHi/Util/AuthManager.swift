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
    
    static let a = true
    
    static func checkRecordable() -> Observable<RXAudioError>{
        return Observable.create { observer in
//            AVAudioSession.sharedInstance().requestRecordPermission { granted in
//                if granted {
//                    observer.onCompleted()
//                } else{
//                    observer.onNext(RXAudioError.RecordError)
//                }
//            }
            if a == true{
                observer.onCompleted()
            } else{
                observer.onNext(RXAudioError.AudioOff)
            }
            return Disposables.create()
        }
    }
    
    static func checkMicUsableRX() -> Observable<RXAudioError>{
        return Observable.create { observer in
//            let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
//            switch micStatus{
//            case .authorized:
//                observer.onCompleted()
//            case .denied, .notDetermined, .restricted:
//                observer.onNext(RXAudioError.AudioOff)
//            @unknown default:
//                observer.onNext(RXAudioError.TotalAudioError)
//            }
            
            if a == true{
                observer.onCompleted()
            } else{
        
                observer.onNext(RXAudioError.TotalAudioError)

            }
            return Disposables.create()
        }
    }
    
    static func checkSpeechableRX() -> Observable<RXAudioError>{
        return Observable.create { observer in
//            let speechStatus = SFSpeechRecognizer.authorizationStatus()
//            switch speechStatus{
//            case .authorized:
//                observer.onCompleted()
//            case .denied, .notDetermined, .restricted:
//                observer.onNext(RXAudioError.SpeechAuth)
//            @unknown default:
//                observer.onNext(RXAudioError.SpeechError)
//            }
            
            if a == true{
                observer.onCompleted()
            } else{
                
                observer.onNext(RXAudioError.RecordError)
            }
            return Disposables.create()
        }
    }
}
