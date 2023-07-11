//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech
import AVFoundation

protocol STTEngineDelegate:BaseDelegate,AnyObject{
    func runRecognizer(_ text:String)
}

final class STTEngine{
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
    private var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private weak var delegate:STTEngineDelegate?
    
    init(controller:STTEngineDelegate){
        self.delegate = controller
        guard let speechController = controller as? SFSpeechRecognizerDelegate else {return}
        self.speechRecognizer.delegate = speechController
        
        print("------------------------------------")
        print("👍🏻👍🏻👍🏻👍🏻👍🏻👍🏻")
        print("------------------------------------")
    }
    
    func getAuthorization(){
        let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        print(micStatus)
        switch micStatus{
        case .authorized:
            getSpechAuthorization()
        case .restricted:
            delegate?.handleError(AudioError.TotalAudioError)
        case .denied, .notDetermined:
            delegate?.handleError(AudioError.AudioOff)
        @unknown default:
            break
        }
    }
    
   private func getSpechAuthorization(){
       let speechStatus = SFSpeechRecognizer.authorizationStatus()
       print(speechStatus)
       switch speechStatus{
       case .authorized:
           startEngine()
       case .denied, .notDetermined:
           delegate?.handleError(AudioError.SpeechAuth)
       case .restricted:
           delegate?.handleError(AudioError.SpeechError)
       @unknown default:
           break
       }
    }

    func startEngine(){
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.record)
                try audioSession.setMode(AVAudioSession.Mode.measurement)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.handleError(AudioError.AudioOff)
                }
            }
            
            self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = self.recognitionRequest else { return }
            recognitionRequest.shouldReportPartialResults = true
            self.runRecognizer()
        }
    }
    
    private func runRecognizer(){
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
                
                guard let recognitionRequest = self.recognitionRequest else { return }
                
                self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                    
                    var isFinal = false
                    
                    if result != nil {
                        let text = result?.bestTranscription.formattedString
                        guard let text = text else { return }
                        DispatchQueue.main.async {
                            self.delegate?.runRecognizer(text)
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
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.handleError(AudioError.TotalAudioError)
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
    
    deinit{
        print("------------------------------------")
        print("👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻")
        print("------------------------------------")
    }
}


