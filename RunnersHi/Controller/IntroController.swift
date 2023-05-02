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
//        introView.imgView.frame = view.bounds
//        introView.addSubview(introView.imgView)
    }
    
    override func loadView() {
        view = introView
    }
}
