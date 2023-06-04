//
//  AppDelegate.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/09.
//

import UIKit

let initialKey = "initialKey"
let thresholdKey = "thresholdKey"
let homePath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var libraryFolderUrl = homePath.appendingPathComponent(Global.PHOTODB, isDirectory: true)
        print(libraryFolderUrl)

                if !UserDefaults.standard.bool(forKey: initialKey){
                    //처음 부팅
                    let defaultSettings = [thresholdKey:123] as [String:Any]
                    UserDefaults.standard.register(defaults: defaultSettings)
                    do{
                        try FileManager.default.createDirectory(at: libraryFolderUrl, withIntermediateDirectories: true)
                        var value = try libraryFolderUrl.resourceValues(forKeys: [.isExcludedFromBackupKey])
                        value.isExcludedFromBackup = true
                        try libraryFolderUrl.setResourceValues(value)
                        print("wonsang: created directory")
                    }catch{
                        print("wonsang: create lib folder error")
                    }
        
                    UserDefaults.standard.set(true, forKey: initialKey)
                    print("initial launch")
                    return true
                } else{
                    print("두번째")
                    return true
                }
            }
        
        // MARK: UISceneSession Lifecycle
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            
        }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // 여기에 타이머 중지
        // 활성화 되어 있는 컨트롤러 찾아서 타이머가 있다면 중지시켜야함.
        
         
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 다시 시작
        // 활성화 되어 있는 컨트롤러 찾아서 타이머가 있다면 재시작 시켜야함
    }
    }
