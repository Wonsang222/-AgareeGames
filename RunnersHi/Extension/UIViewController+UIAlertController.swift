//
//  VC+AlertRX.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController{
    func alertRX(message:String, okAction:@escaping (UIAlertAction) -> Void, cancelAction:((UIAlertAction)->Void)? = nil) -> Completable {
        return Completable.create { [unowned self] completable in
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: .default, handler: okAction)
            
            alert.addAction(action)
            
            if let cancelAction = cancelAction{
                let action = UIAlertAction(title: "취소", style: .default, handler: cancelAction)
                alert.addAction(action)
            }
            
            self.present(alert, animated: true)
            
            return Disposables.create(){
                self.dismiss(animated: true)
            }
        }
        
    }
    
    func alert(message:String, agree:((UIAlertAction)->Void)?, disagree:((UIAlertAction)->Void)? = nil){
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
}



