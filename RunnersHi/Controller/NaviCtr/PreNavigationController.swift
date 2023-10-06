//
//  CustomUINavigationController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit

final class PreNavigationController:UINavigationController{
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    
    override func viewDidLoad() {
    }
}
