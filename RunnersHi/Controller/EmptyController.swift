//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit

class EmptyController:BaseController{
    
    let mainView = GuessWhoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
    }
    
    override func loadView() {
        view = mainView
    }
    
    func test(){
        Task{
            NetworkService.fetchJSON(httpbaseresource:)
        }
    }
}
