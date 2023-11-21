//
//  STTEngineRX.swift
//  AgareeGames
//
//  Created by 황원상 on 11/18/23.
//

import Foundation
import RxSwift
import Speech
import AVFoundation


final class STTEngineRX:NSObject {
    
    static let shared = STTEngineRX()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var submittedText = ""
    let submit = PublishSubject<String>()
    
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
            sub.onCompleted()
        
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
    func runRecognizer() -> Observable<String> {
        return Observable.create { [unowned self] ob in
            
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
                return Disposables.create()
            }
            
            self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest,
                                                                         resultHandler: { (result, error) in
                
                var isFinal = false
                
                if result != nil {
                    let text = result?.bestTranscription.formattedString
                    guard let text = text else { return }
                    
                    self.submittedText = text
                    self.submit.onNext(submittedText)
            
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
            return Disposables.create()
        }
    }
    
    func resetText() {
        submittedText = ""
    }

    /*
     1. custom rx extension 구현
     2. kvo 사용 avaudioengine이 kvo 를 지원하는가 -> 지원 x
     */
    
    private override init () { }
}




