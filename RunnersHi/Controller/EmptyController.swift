//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit

class EmptyController:BaseController{
    
    let mainview = PreGameView(gameTitle: "인물퀴즈")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
        
        view.addSubview(mainview)
        
        NSLayoutConstraint.activate([
            mainview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])


    }
}
