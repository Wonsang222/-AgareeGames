//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/04/26.
//

import UIKit
import Speech

final class GuessWhoController:BaseController{
    
    //MARK: - Properties
    private let guessWhoView = GuessWhoView()
    private var engine:STTEngine?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        engine = STTEngineFactory.create(self)
    }
    
    override func loadView() {
        view = guessWhoView
    }
    
    //MARK: - Methods

    
}

//MARK: - Extension
extension GuessWhoController:SFSpeechRecognizerDelegate{
    
}
