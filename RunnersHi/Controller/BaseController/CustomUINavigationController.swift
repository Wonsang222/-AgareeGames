//
//  CustomUINavigationController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit

final class CustomUINavigationController:UINavigationController{

    override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
    
    override var childForStatusBarHidden: UIViewController?{
        return topViewController
    }
    
    override var childForHomeIndicatorAutoHidden: UIViewController?{
        return topViewController
    }
    
    override func viewDidLoad() {
    }
}
