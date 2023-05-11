//
//  GameController.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

@objc protocol TimerUsable{
    var numToCount:Float { get }
    var speed:Float { get }
    @objc func startGameTimer()
}

class GameController:BaseController{
    var timer:Timer?
    var numToCount: Float = 0.0
    var speed:Float = 0.0
    var timerNumber = 0
    
    let countView:UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let progressView:UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .default
        pv.tintColor = .systemBlue
        pv.trackTintColor = .lightGray
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .partialCurl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // navigation item "player number"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 타이머 1개 유지
        // 게임중 나가면 어케할건지... 걍 냅두면 이어지나 테스트
        // 이게 맞나 고민요망
        // navigationbar 올림?
        timer?.invalidate()
        timer = nil
        timerNumber -= 1
    }
    // background runloop 게임중 사용해야하나..
    
    func setTimer(_ second:Float, userinfo:Any? = nil, repeater:Bool){
        timerNumber += 1
        self.speed = (1.0 / second) * 0.1
        
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(startGameTimer), userInfo: userinfo, repeats: repeater)
        RunLoop.current.add(timer!, forMode: .common)
        timer?.fire()
    }
 
    func startCounter(completion:@escaping()->Void){
        UIView.transition(with: countView, duration: 2, options: [.transitionFlipFromTop]) {
            self.countView.image = UIImage(systemName: "3.circle")
            self.countView.layoutIfNeeded()
        } completion: { finished in
            UIView.transition(with: self.countView, duration: 2, options: [.transitionFlipFromTop]) {
                self.countView.image = UIImage(systemName: "2.circle")
                self.countView.layoutIfNeeded()
            } completion: { finished in
                UIView.transition(with: self.countView, duration: 2, options: [.transitionFlipFromTop]) {
                    self.countView.image = UIImage(systemName: "1.circle")
                    self.countView.layoutIfNeeded()
                } completion: { finished in
                    completion()
                }
            }
        }
    }
}

extension GameController:TimerUsable{
    
   @objc func startGameTimer() {
       // abstract
    }
}
