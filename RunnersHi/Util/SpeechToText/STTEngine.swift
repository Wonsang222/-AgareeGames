//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech

// 사자성어 대비해서 subclassing해야하나...

 class STTEngine{
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let controller:BaseController
    
    init(controller:BaseController){
        self.controller = controller
        guard let speechController = controller as? SFSpeechRecognizerDelegate else {return}
        self.speechRecognizer.delegate = speechController
    }
    
    func runRecognizer(completion:()->Void){
        if audioEngine.isRunning{
            audioEngine.stop()
            recognitionRequest.endAudio()
            completion()
        } else{
            startRecording()
            completion()
        }
    }
    
    func startRecording(){
        if recognitionTask != nil{
            recognitionTask?.cancel()
            recognitionTask = nil
        }
    }
}

class STTEngineFactory{
    static func create(_ controller:BaseController)-> STTEngine{
        return STTEngine(controller: controller)
    }
}
