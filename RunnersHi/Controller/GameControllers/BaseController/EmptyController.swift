//
//  EmptyController.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/28.
//

import UIKit

// 게임 중지시, rootcontoller로 돌아가기위함.

class EmptyController:BaseController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.popToRootViewController(animated: true)
    }
}
