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

final class STTEngineRX {
    
    static let shared = STTEngineRX()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var submittedText = ""
    
    private let bag = DisposeBag()
    // oop 관점에서 좋은 publishRelay가 좋은 선택인지 모르겠다.
    let textRelay = PublishRelay<String>()
    private let serialScheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    
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
    
    //serial queue에서 submittedText에 접근하고 textRealay로 전달 -> race condition -> recognitionTask 내부적 serial 처리
    @discardableResult
    func runRecognizer() -> Completable {
        
        let sub = PublishSubject<Never>()
        
        print("start")
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
                        print(submittedText)
                        self.textRelay.accept(submittedText)
                        
                        isFinal = (result?.isFinal)!
                    }
                    
                    // 에러 발생
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
            sub.onCompleted()
        } catch {  }
        return sub.asCompletable()
    }
    
    @discardableResult
    func resetText() -> Completable {
        let sub = PublishSubject<Never>()
        
        submittedText = ""
        sub.onCompleted()
        return sub.asCompletable()
        
    }
    private init () {}
}




