//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit

class EmptyController:BaseController{

    
    let imgView:UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
        
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let base = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setPath("guessWho")
            .setParams("num", 3)
            .build()
        


    }
}
