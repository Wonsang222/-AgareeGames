//
//  ResultController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit

final class ResultController:SettingController{
    
    var isWin:Bool
    
    override func loadView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTheResult()
        configureNaviBar()
    }
    
    init(isWin: Bool) {
        self.isWin = isWin
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNaviBar(){
        // navigation button
        // 3... 2... 1... popto rootView
    }
    
    func checkTheResult(){
        if isWin{
            
        } else {
            
        }
    }
}
