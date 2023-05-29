//
//  BaseController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

class BaseController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
            
    final func alert(message:String, agree:((UIAlertAction)->Void)?, disagree:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        if let agree = agree, let disagree = disagree {
            let agreeAction = UIAlertAction(title: "확인", style: .default, handler: agree)
            let disagreeAction = UIAlertAction(title: "취소", style: .default, handler: disagree)
            alert.addAction(agreeAction)
            alert.addAction(disagreeAction)
        }
        self.present(alert, animated: true)
    }
    
    final func goBackToRoot(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    final func terminateAppGracefullyAfter(second: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(1) // Exit Failure
            }
        }
    }

    // 유저에게 치명적 오류가 발생했음을 알리고, 앱 종료에 대한 선택권을 주는 Alert
//    func showAppTerminatingAlert() {
//        let title = "시스템 오류가 발생했습니다."
//        let message = "앱이 5초 뒤 종료됩니다...\n개발자에게 문의해주세요."
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let terminateAction = UIAlertAction(title: "지금 종료", style: .destructive) { _ in
//            self.terminateAppGracefullyAfter(second: 0) // 즉시 우아한 앱 종료
//        }
//            
//        alert.addAction(terminateAction)
//        present(alert, animated: true) {
//            self.terminateAppGracefullyAfter(second: 5.0) // 5초 후 우아한 앱 종료
//        }
//    }
    
//    // do-try-catch 문
//    do {
//        try someMethodThatThrowsErrors()
//        } catch someError.errorOne {
//            doSomeAction()
//        } catch someError.errorTwo {
//            doSomeAction2()
//        } catch {
//            // 우아한 앱 종료 Alert 메서드 삽입
//            showAppTerminatingAlert()
//    }
}



