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



