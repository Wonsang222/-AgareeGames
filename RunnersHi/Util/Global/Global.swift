//
//  Global.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

struct Global{
    
    //MARK: - Game Setting
    static let GAMESPEED:Float = 5.0
    static let APPFONT = "Goryeong-Strawberry"
    static let PHOTODB = "PhotoDB"
    
    //MARK: - Network Setting
    static let BUNDLEIDENTIFIER = "com.kr.magic"
    static let UUID = "59287382-e52d-4090-a829-864b5b578bc1"
    #if DEV
    static let URL = "http://192.168.200.121:8080"
    #else
    static let URL = "https://agareegames.fly.dev"
    #endif
    static let PHOTODBURL = FileManager().urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent(Global.PHOTODB, isDirectory: true)
}
