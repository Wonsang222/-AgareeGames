//
//  AgareeDelegate.swift
//  AgareeGames_dis
//
//  Created by 위사모바일 on 2023/06/07.
//

import UIKit

let initialKey = "initialKey"
let thresholdKey = "thresholdKey"
let homePath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!

class AgareeDelegate: UIResponder, UIWindowSceneDelegate, UIApplicationDelegate{
    
    var window: UIWindow?
    
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
        } else{
            // 여기서 로딩하거나...
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = CustomUINavigationController(rootViewController: PreGameController(gameTitle: "인물게임"))
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print(#function)
        if let rootVC = (scene as? UIWindowScene)?.windows.first?.rootViewController{
            if let root = rootVC as? GameController{
                print("game Controller")
            }
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print(#function)
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print(#function)
        if let rootVC = (scene as? UIWindowScene)?.windows.first?.rootViewController{
            print(rootVC)
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print(#function)
        if let rootVC = (scene as? UIWindowScene)?.windows.first?.rootViewController{
            print(rootVC)
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print(#function)
        guard let window = UIApplication.shared.keyWindow else {return}

            
    }
    
}
