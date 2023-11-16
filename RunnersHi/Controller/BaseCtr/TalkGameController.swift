//
//  TalkGameController.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/23.
//

import UIKit
import Speech

class TalkGameController:BaseController{
    
    var engine:STTEngine?
    
    final var answer = ""{
        didSet{
            print(answer)
            checkTheProcess()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        engine?.startEngine()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        engine?.offEngine()
        engine = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkTheProcess(){
        //abstract
    }
    
    func checkTheAnswer()->Bool{
        // abstract
        return true
    }
}

