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
        guessWhoView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func loadView() {
        view = guessWhoView
    }
    
    //MARK: - Methods
    @objc func buttonTapped(){
        engine.runRecognizer {
            print(123123)
        } mainHandler: {
            print(456456)
        }
    }
    
    // you wanna get nuts ? let get nuts
}

//MARK: - Extension
extension GuessWhoController:SFSpeechRecognizerDelegate{
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
    }
}
