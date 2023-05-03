//
//  BaseController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

class BaseController:UIViewController{
            
    func alert(message:String, agree:((UIAlertAction)->Void)? = nil, disagree:((UIAlertAction)->Void)? = nil){
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let agree = UIAlertAction(title: "확인", style: .default, handler: agree)
        let disagree = UIAlertAction(title: "취소", style: .default, handler: disagree)
        
        alert.addAction(agree)
        alert.addAction(disagree)
        
        self.present(alert, animated: true)
    }
}

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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 타이머 1개 유지
        // 게임중 나가면 어케할건지... 걍 냅두면 이어지나 테스트
        // 이게 맞나 고민요망
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

class SettingController:BaseController{
    
}


class CustomUINavigationController:UINavigationController{

    override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
    
    override var childForStatusBarHidden: UIViewController?{
        return topViewController
    }
    
    override func viewDidLoad() {
        
    }
}
