//
//  STTEngineRX.swift
//  AgareeGames
//
//  Created by 황원상 on 11/18/23.
//

import Foundation
import RxSwift
import RxRelay
import Speech
import AVFoundation


final class STTEngineRX:NSObject {
    
    static let shared = STTEngineRX()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var submittedText = ""
    let submit = PublishRelay<String>()
    
    @discardableResult
    func startEngine()  -> Completable {
        let sub = PublishSubject<Never>()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {}
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = self.recognitionRequest else {

            return .error(NSError(domain: "temp", code: 111))
        }
        recognitionRequest.shouldReportPartialResults = true
       
        
        
        
        
        return sub.asCompletable()
    }
    
    @discardableResult
    func offEngine() -> Completable {
        let sub = PublishSubject<Never>()
        
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        sub.onCompleted()
        
        return sub.asCompletable()
    }
    
    @discardableResult
    func runRecognizer() -> Completable {
        
        let sub = PublishSubject<Never>()
        
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.audioEngine.inputNode.removeTap(onBus: 0)
        }
        
        if self.recognitionTask != nil {
            self.recognitionTask?.cancel()
            self.recognitionTask = nil
        }
        
        let inputNode = self.audioEngine.inputNode
        
        guard let recognitionRequest = self.recognitionRequest else {
            return sub.asCompletable()
        }
        
        self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest,
                                                                     resultHandler: { [unowned self] (result, error) in
            
            var isFinal = false
            
            if result != nil {
                let text = result?.bestTranscription.formattedString
                guard let text = text else { return }
                
                self.submittedText += text
                self.submit.accept(submittedText)
                
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
        
        do {
            try self.audioEngine.start()
        } catch {  }
        return sub.asCompletable()
    }
    
    func resetText() -> Completable {
        let sub = PublishSubject<Never>()
        
        submittedText = ""
        sub.onCompleted()
        return sub.asCompletable()
        
    }
    
    private override init () { }
}




