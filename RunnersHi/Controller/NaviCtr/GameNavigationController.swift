//
//  GameNavigationController.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/10/06.
//

import UIKit

final class GameNavigationController:UINavigationController{
        
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }

    
    override func viewDidLoad() {
    }
}
