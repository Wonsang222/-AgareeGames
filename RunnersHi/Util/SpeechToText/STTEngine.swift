//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech

/*
 Game time : 3 second
 success condition : say right name in 3 seconds
    1. no extra words for the answer
    2. with some extra words for the answer -> check. analysis
 
 problem
    1. understanding each component
    2. how to attach it to GameController (Protocol?)
 */

 class STTEngine{
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let controller:BaseController
    
    init(controller:BaseController){
        self.controller = controller
        guard let speechController = controller as? SFSpeechRecognizerDelegate else {return}
        self.speechRecognizer.delegate = speechController
    }

     
     func runRecognizer(completion:()->Void, mainHandler:@escaping()->Void){
        if audioEngine.isRunning{
            audioEngine.stop()
            recognitionRequest?.endAudio()
            completion()
        } else{
            startRecording(completion:mainHandler)
            completion()
        }
    }
    
     private func startRecording(completion:@escaping()->Void){
        if recognitionTask != nil{
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
        }catch{
            print("audio error")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("audio error")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            
            var isFinal = false
            
            if result != nil{
                completion()
            }
            
            if error != nil || isFinal{
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
         
         let recordingFormat = inputNode.outputFormat(forBus: 0)
         inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
             self.recognitionRequest?.append(buffer)
         }
         
         audioEngine.prepare()
         
         do {
             try audioEngine.start()
         } catch {
             print("audioEngine couldn't start because of an error.")
         }
    }
}

class STTEngineFactory{
    static func create(_ controller:BaseController)-> STTEngine{
        return STTEngine(controller: controller)
    }
}
