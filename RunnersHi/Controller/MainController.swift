//
//  MainController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

final class MainContoller:SettingController{
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
    }
}
