//
//  TalkGameController.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/23.
//

import UIKit

class TimerGameCotoller:GameController{
    var timer:Timer?
    var numToCount: Float = 0.0
    var speed:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 타이머 1개 유지
        // 게임중 나가면 어케할건지... 걍 냅두면 이어지나 테스트
        // 이게 맞나 고민요망
        // navigationbar 올림?
        //        timer?.invalidate()
        //        timer = nil
        //        timerNumber -= 1
        
    }
    
    func setTimer(_ second:Float, userinfo:Any? = nil, repeater:Bool){
        guard timer == nil else { return }
        numToCount = 0.0
        self.speed = (1.0 / second) * 0.1
        
        DispatchQueue.global().async {[weak self] in
            guard let self = self else {return}
            self.timer = Timer(timeInterval: 0.2, target: self, selector: #selector(self.startGameTimer(_:)), userInfo: userinfo, repeats: repeater)
            RunLoop.current.add(self.timer!, forMode: .common)
            self.timer?.fire()
            RunLoop.current.run()
        }
    }    
}

extension TimerGameCotoller:TimerUsable{
    @objc func startGameTimer(_ timer:Timer) {
        // abstract
    }
}
