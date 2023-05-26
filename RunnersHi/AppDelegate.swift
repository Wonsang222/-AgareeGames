//
//  AppDelegate.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/09.
//

import UIKit

let initialKey = "initialKey"
let thresholdKey = "thresholdKey"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if !UserDefaults.standard.bool(forKey: initialKey){
            //처음 부팅
            
            UserDefaults.standard.set(true, forKey: initialKey)
            print("initial launch")
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  
    }
}

