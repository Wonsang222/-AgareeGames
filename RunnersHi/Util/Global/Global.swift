//
//  Global.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

struct Global{
    
    //MARK: - Game Setting
    static let GAMESPEED:Float = 4.0
    static let APPFONT = "Goryeong-Strawberry"
    
    //MARK: - Network Setting
//    static let BUNDLEIDENTIFIER = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
    static let BUNDLEIDENTIFIER = "com.kr.magic"
    static let UUID = "59287382-e52d-4090-a829-864b5b578bc1"
    static let URL = "http://localhost:8001"
    
    static var gameDic:[String:String] = ["인물퀴즈":"guessWhoController"]
}
