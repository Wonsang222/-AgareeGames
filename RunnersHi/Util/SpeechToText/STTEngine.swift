//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

/*
 audio setting background.. count 보다 먼저 세팅만 먼저하고
 실행은 뒤로 미룬다...
 메인쓰레드 부하 줄이기
 메인쓰레드로 보내는거 dispatchqueue main ㅈ다시 스코프 짜보자
 */

import UIKit
import Speech

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
    // 앱 background 갈때 audioEngine stop되는지 확인
    
    func startEngine(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.record)
                try audioSession.setMode(AVAudioSession.Mode.measurement)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print("audioSession properties weren't set because of an error.")
                self.controller.alert(message: "디바이스 오디오에 문제가 있습니다. \n 휴대폰 기기를 확인해주세요", agree: nil, disagree: nil)
            }
            
            self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = self.recognitionRequest else { return }
            recognitionRequest.shouldReportPartialResults = true
        }
    }
    
    
    func runRecognizer(completion:@escaping (Result<String, Error>) -> Void){
        
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
                            completion(.success(text))
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
                
                do {
                    try self.audioEngine.start()
                } catch {
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


