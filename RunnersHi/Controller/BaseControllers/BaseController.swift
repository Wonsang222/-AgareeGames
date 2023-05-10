//
//  BaseController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

class BaseController:UIViewController{
            
    func alert(message:String, agree:((UIAlertAction)->Void)?, disagree:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        if let agree = agree, let disagree = disagree {
            let agreeAction = UIAlertAction(title: "확인", style: .default, handler: agree)
            let disagreeAction = UIAlertAction(title: "취소", style: .default, handler: disagree)
            alert.addAction(agreeAction)
            alert.addAction(disagreeAction)
        }
        self.present(alert, animated: true)
    }
}



