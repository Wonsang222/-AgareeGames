//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/04/26.
//

import UIKit
import Speech

class GuessWhoController:BaseController{
    
    //MARK: - Properties
    
    let guessWhoView = GuessWhoView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        
    }
    
    override func loadView() {
        view = guessWhoView
    }
}

//MARK: - Extension

extension GuessWhoController:SFSpeechRecognizerDelegate{
    
}
