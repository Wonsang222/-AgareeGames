//
//  STT.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

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
        setAudio()
    }
     // 앱 background 갈때 audioEngine stop되는지 확인
     
     func setAudio(){
         let audioSession = AVAudioSession.sharedInstance()
         do{
             try audioSession.setCategory(AVAudioSession.Category.record)
             try audioSession.setMode(AVAudioSession.Mode.measurement)
             try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
             
         }catch{
             controller.alert(message: "오디오 에러입니다. \n휴대폰의 오디오를 확인해주세요.", agree: nil, disagree: nil)
         }
         
         // 음성인식요청 처리기
         recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
         guard let recognitionRequest = recognitionRequest else {
             fatalError("audio error")
         }
         recognitionRequest.shouldReportPartialResults = true
     }
     
     
     
     func runRecognizer(completion:@escaping (Result<String, Error>) -> Void){
//         if audioEngine.isRunning{
//             audioEngine.stop()
//             recognitionRequest?.endAudio()
//             print("✋✋✋✋✋✋✋✋✋✋✋✋✋✋✋✋✋✋✋✋")
//             return
//         }
         //  음성요청인식 결과 제공
         if recognitionTask != nil{
             recognitionTask?.cancel()
             recognitionTask = nil
         }

         let inputNode = audioEngine.inputNode
         
         guard let recognitionRequest = recognitionRequest else {
             controller.alert(message: "오디오 에러입니다. \n휴대폰의 오디오를 확인해주세요.", agree: nil, disagree: nil)
             return
         }
         
         // 음성인식 및 결과 받아오기
         recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { [weak self] (result, error) in
             guard let self = self else { return }
             
             var isFinal = false
             
             if result != nil{
                 isFinal = (result?.isFinal)!
                 completion(.success(result?.bestTranscription.formattedString ?? " "))
             }
             
             if error != nil || isFinal{
                 self.audioEngine.stop()
                 inputNode.removeTap(onBus: 0)
                 
                 self.recognitionRequest = nil
                 self.recognitionTask = nil
                 
                 completion(.failure(error!))
             }
         })
         
         let recordingFormat = inputNode.outputFormat(forBus: 0)
         inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, when) in
             guard let self = self else { return }
             self.recognitionRequest?.append(buffer)
         }
         
         audioEngine.prepare()
         
         do {
             try audioEngine.start()
         } catch{
             controller.alert(message: "오디오 에러", agree: nil, disagree: nil)
         }
    }
     
     func resetRecognizer(){
         recognitionTask?.cancel()
         audioEngine.stop()
         recognitionRequest?.endAudio()
         recognitionRequest = nil
         recognitionTask = nil
     }
}


