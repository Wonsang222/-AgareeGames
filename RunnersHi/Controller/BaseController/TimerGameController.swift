//
//  TalkGameController.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/23.
//

import UIKit

// 런루프 손봐야함

class TimerGameCotoller:GameController{
    final var timer:Timer?
    final var numToCount: Float = 0.0
    final var speed:Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    final func setTimer(_ second:Float, userinfo:Any? = nil, repeater:Bool){
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
    
    @objc func startGameTimer(_ timer:Timer) {
        // abstract
    }
}
