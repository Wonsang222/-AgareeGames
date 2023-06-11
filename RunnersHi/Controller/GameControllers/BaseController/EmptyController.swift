//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit

class EmptyController:BaseController{
    
    let mainView = HowToPlayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}
