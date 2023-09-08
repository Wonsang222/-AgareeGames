//
//  AuthorizationManager.swift
//  AgareeGames_dis
//
//  Created by 위사모바일 on 2023/07/11.
//

import UIKit
import Speech
import AVFoundation


class AuthManager{

    func getMicAuthorization(){
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                self.getSpechAuthorization()
            }
        }
    }
    
    func getSpechAuthorization(){
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
    
    func isMicUsable() -> Bool{
        let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch micStatus{
        case .authorized:
            return true
        case .denied, .notDetermined, .restricted:
            return false
        @unknown default:
            return false
        }
    }
    
    func isSpeechable()-> Bool{
        let speechStatus = SFSpeechRecognizer.authorizationStatus()
        switch speechStatus{
        case .authorized:
            return true
        case .denied, .notDetermined, .restricted:
            return false
        @unknown default:
            return false
        }

    }
    
    
    
}
