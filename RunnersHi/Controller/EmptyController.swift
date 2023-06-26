//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit

class EmptyController:BaseController{

    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
        
        let base = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setPath("guessWho")
            .setParams("num", 3)
            .build()
        
        Task{
            do{
                let data = try await NetworkService.fetchJSON(httpbaseresource:base)
            } catch{
                
            }
        }
    }
}
