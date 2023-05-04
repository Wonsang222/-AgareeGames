//
//  GameController.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

class GameController:BaseController{
    let countView = CountView()
    var timer:Timer?
    var numToCount:Int?
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .partialCurl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // navigationbar 내림
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 타이머 1개 유지
        // 게임중 나가면 어케할건지... 걍 냅두면 이어지나 테스트
        // 이게 맞나 고민요망
        // navigationbar 올림?
        timer?.invalidate()
        timer = nil
    }
    // background runloop 게임중 사용해야하나..
    func setTimer(second:Int, selector:Selector, userinfo:Any? = nil, repeater:Bool, num:Int){
        numToCount = num
        timer = Timer(timeInterval: TimeInterval(second), target: self, selector: selector, userInfo: userinfo, repeats: repeater)
        timer?.tolerance = 0.2
        RunLoop.current.add(timer!, forMode: .common)
        timer?.fire()
    }
}
