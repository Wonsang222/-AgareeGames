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
    weak var delegate:BaseDelegate?
    
    init(delegate: BaseDelegate? = nil) {
        self.delegate = delegate
        getAuth()
    }
    
    func getAuth(){
        switch delegate{
        case _ as TalkGameController:
            getMicAuthorization()
        default:
            break
        }
    }
    
    private func getMicAuthorization(){
        let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        print(micStatus)
        switch micStatus{
        case .authorized:
            getSpechAuthorization()
        case .restricted:
//            delegate?.handleError(AudioError.TotalAudioError)
            print("restricted")
        case .denied, .notDetermined:
            delegate?.handleError(AudioError.AudioOff)
//            print("notdeterminded")
        @unknown default:
            break
        }
    }
    
   private func getSpechAuthorization(){
       let speechStatus = SFSpeechRecognizer.authorizationStatus()
       print(speechStatus)
       switch speechStatus{
       case .authorized:
           print(123)
       case .denied, .notDetermined:
           delegate?.handleError(AudioError.SpeechAuth)
       case .restricted:
//           delegate?.handleError(AudioError.SpeechError)
           print("restricted")
       @unknown default:
           break
       }
    }

    
    
}
