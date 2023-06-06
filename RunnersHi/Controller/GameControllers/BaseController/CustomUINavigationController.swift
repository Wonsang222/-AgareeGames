//
//  CustomUINavigationController.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

final class CustomUINavigationController:UINavigationController{

    override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
    
    override var childForStatusBarHidden: UIViewController?{
        return topViewController
    }
    
    override func viewDidLoad() {
        
        let standard = UINavigationBarAppearance()
        standard.configureWithDefaultBackground()
        
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "kaljfisdjf", style: .plain, target:nil, action: nil)
        
        navigationBar.barStyle = .black
        
    }
}
