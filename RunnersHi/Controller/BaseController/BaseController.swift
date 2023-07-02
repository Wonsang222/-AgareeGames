//
//  BaseController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

class BaseController:UIViewController{
    
    let loader = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    func loaderON(){
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.tintColor = .gray
        loader.startAnimating()
    }
    
    func loaderOFF(){
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
            
    final func alert(message:String, agree:((UIAlertAction)->Void)?, disagree:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        if let agree = agree{
            let agreeAction = UIAlertAction(title: "확인", style: .default, handler: agree)
            alert.addAction(agreeAction)
        }
        
        if let disagree = disagree{
            let disagreeAction = UIAlertAction(title: "취소", style: .default, handler: disagree)
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

//     유저에게 치명적 오류가 발생했음을 알리고, 앱 종료에 대한 선택권을 주는 Alert
    func showAppTerminatingAlert() {
        let title = "시스템 오류가 발생했습니다."
        let message = "앱이 5초 뒤 종료됩니다...\n개발자에게 문의해주세요."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let terminateAction = UIAlertAction(title: "지금 종료", style: .destructive) { _ in
            self.terminateAppGracefullyAfter(second: 0) // 즉시 우아한 앱 종료
        }
            
        alert.addAction(terminateAction)
        present(alert, animated: true) {
            self.terminateAppGracefullyAfter(second: 5.0) // 5초 후 우아한 앱 종료
        }
    }
    
    func checkServerErr(err:MyServer.ErrList){
            switch err{
            case .RateLimit:
                alert(message: err.rawValue, agree: { alert in
                    self.goBackToRoot()
                }, disagree: nil)
            case .OnUpdated:
                alert(message: err.rawValue, agree: { alert in
                    self.goBackToRoot()
                }, disagree: nil)
            case .Unkwown:
                alert(message: err.rawValue, agree: { alert in
                    self.goBackToRoot()
                }, disagree: nil)
            }
    }
    
    func handleErrors(error:Error){
        switch error{
        case is AudioError:
            self.alert(message: "Audio 오류 발생했습니다. \n 앱을 다시 실행해 주세요.", agree: { [weak self] alert in
                self?.terminateAppGracefullyAfter(second: 0)
            }, disagree: nil)
        case is URLError:
            self.alert(message: "현재 서버와 연결이 어렵습니다. \n 잠시 후 다시 시도해주세요.", agree: { alert in
                self.goBackToRoot()
            }, disagree: nil)
        default:
            terminateAppGracefullyAfter(second: 5.0)
        }
    }
}
