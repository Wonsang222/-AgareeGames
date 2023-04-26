//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech

// 팩토리 패턴으로 해야하나

class STTEngine{
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let controller:BaseController
    
    init(controller:BaseController){
        
        self.controller = controller
    }
    
}


class STTEngineFactory{
    static func create(_ controller:BaseController)-> STTEngine{
        return STTEngine(controller: controller)
    }
}
