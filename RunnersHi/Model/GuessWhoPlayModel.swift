//
//  GuessWhoPlayModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/21.
//
import UIKit
import RxSwift


struct GuessWhoPlayModel:Playable {

    let name:String
    var photo:UIImage?
    
    init(name:String, photo:UIImage? = nil) {
        self.name = name
        self.photo = photo
    }
}




