//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech

final class GuessWhoController:GameController{
    //MARK: - Properties
    private let guessWhoView = GuessWhoView()
    private var engine:STTEngine!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        engine = STTEngineFactory.create(self)
        
//        guessWhoView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTimer(second: 1, selector: #selector(startGameTimer), repeater: true, num: 3)
    }
    
    override func loadView() {
        view = guessWhoView
    }
    
    //MARK: - Methods
    @objc func buttonTapped(){
        engine.runRecognizer { result in
            switch result{
            case .success(let res):
                print(res)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @objc func startGameTimer(){
        guessWhoView.txtView.text = "\(numToCount!)"
        numToCount = numToCount! - 1
        
        if numToCount == 0{
            timer?.invalidate()
            timer = nil
        }
        Thread.sleep(forTimeInterval: 1)
    }
}

//MARK: - Extension
extension GuessWhoController:SFSpeechRecognizerDelegate{
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
    
        
    }
}
