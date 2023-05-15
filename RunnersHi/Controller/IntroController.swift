//
//  IntroController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

final class IntroController: BaseController {
    
    let introView = IntroView()

    override func viewDidLoad() {
        super.viewDidLoad()
        introView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(introView)
     
        NSLayoutConstraint.activate([
            introView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            introView.heightAnchor.constraint(equalToConstant: 200),
            introView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()

    }
}
