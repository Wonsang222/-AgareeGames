//
//  BaseController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

class BaseController:UIViewController{
    
    final let loader = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    final func loaderON(){
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.tintColor = .gray
        loader.startAnimating()
    }
    
    final func loaderOFF(){
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
            
    final func alert(message:String, agree:((UIAlertAction)->Void)?, disagree:((UIAlertAction)->Void)? = nil){
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
    final func showAppTerminatingAlert() {
        let title = "시스템 오류가 발생했습니다."
        let message = "앱이 5초 뒤 종료됩니다...\n개발자에게 문의해주세요."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let terminateAction = UIAlertAction(title: "지금 종료", style: .destructive) { _ in
            self.terminateAppGracefullyAfter(second: 0)
        }
            
        alert.addAction(terminateAction)
        present(alert, animated: true) {
            self.terminateAppGracefullyAfter(second: 5.0) // 5초 후 우아한 앱 종료
        }
    }
    
    final func handleErrors(error:Error){
        switch error{
        case let audioErr as AudioError:
            handleAudioError(err: audioErr)
        case let serverErr as MyServer.ErrList:
            handleServerErr(err: serverErr)
            // fly io 서버 리부팅에 대한 error 처리
        case is URLError:
            self.alert(message: "현재 서버와 연결이 어렵습니다. \n 잠시 후 다시 시도해주세요.", agree: { alert in
                self.goBackToRoot()
            }, disagree: nil)
        default:
            showAppTerminatingAlert()
        }
    }
    
   final func handleServerErr(err:MyServer.ErrList){
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
            case .WrongAccess:
                break
            }
    }
    
    final func handleAudioError(err:AudioError){
        print(err)
        switch err{
        case .TotalAudioError:
            alert(message: err.rawValue) { alert in
                self.goBackToRoot()
            }
        case .AudioOff:
            alert(message: err.rawValue) { alert in
                if let appSetting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSetting)
                }
            }
        case .SpeechAuth:
            alert(message: err.rawValue) { alert in
                if let appSetting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSetting)
                }
            }
        case .SpeechError:
            alert(message: err.rawValue) { alert in
                self.goBackToRoot()
            }
        }
    }
}
