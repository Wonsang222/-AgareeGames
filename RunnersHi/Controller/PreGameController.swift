//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit

class PreGameController:SettingController{
    
    let preGameView = PreGameView()
    
    override func loadView() {
        view = preGameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
