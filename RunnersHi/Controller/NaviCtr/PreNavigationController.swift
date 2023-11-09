//
//  PreNavigationController.swift
//  AgareeGames
//
//  Created by 위사모바일 on 11/9/23.
//

import UIKit

class PreNavigationController:BaseNavigationController {
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        
    }
}
