//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

/*
 
 에러처리 해야함
 의존성 주입 -> 처음엔 abstract로 클래스 나눴었다.
 
 */

import UIKit
import Speech

protocol STTEngineDelegate:BaseDelegate{
    func runRecognizer(_ text:String)
}

final class STTEngine{
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let controller:STTEngineDelegate
    
    init(controller:STTEngineDelegate){
        self.controller = controller
        guard let speechController = controller as? SFSpeechRecognizerDelegate else {return}
        self.speechRecognizer.delegate = speechController
    }
    
    func startEngine(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.record)
                try audioSession.setMode(AVAudioSession.Mode.measurement)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                controller.handleError(error)
            }
            
            self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = self.recognitionRequest else {
                fatalError("recognitionRequest optional binding error!")
            }
            recognitionRequest.shouldReportPartialResults = true
        }
    }
    
    func runRecognizer(){
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            if self.audioEngine.isRunning {
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                self.audioEngine.inputNode.removeTap(onBus: 0)
            } else {
                startRecording()
            }
            
            func startRecording(){
                if self.recognitionTask != nil {
                    self.recognitionTask?.cancel()
                    self.recognitionTask = nil
                }
                
                let inputNode = self.audioEngine.inputNode
                
                
                guard let recognitionRequest = self.recognitionRequest else {
                    fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
                }
                
                self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                    
                    var isFinal = false
                    
                    if result != nil {
                        let text = result?.bestTranscription.formattedString
                        guard let text = text else { return }
                        DispatchQueue.main.async {
                            self.controller.runRecognizer(text)
                        }
                        
                        isFinal = (result?.isFinal)!
                    }
                    
                    if error != nil || isFinal {
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
                
                self.audioEngine.prepare()
                
                
                // 여기서 에러를 떤져서 guessWho에서 에러를 다시 받아 실행
                do {
                    try self.audioEngine.start()
                } catch {
                    self.controller.handleError(error)
                    print("audioEngine couldn't start because of an error.")
                }
            }
        }
    }
    
    func offEngine(){
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
    }
}


