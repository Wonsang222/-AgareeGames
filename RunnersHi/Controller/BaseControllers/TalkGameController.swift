//
//  TalkGameController.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/23.
//

import UIKit

class TalkGameController:TimerGameCotoller{
    
    var answer = ""{
        didSet{
            print(answer)
            checkTheProcess()
        }
    }

     func checkTheProcess(){
        //abstract
    }
    
     func checkTheAnswer()->Bool{
        // abstract
         return true
    }
}

