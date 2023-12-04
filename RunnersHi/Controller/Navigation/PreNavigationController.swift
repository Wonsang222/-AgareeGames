//
//  PreNavigationController.swift
//  AgareeGames
//
//  Created by 황원상 on 11/9/23.
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
