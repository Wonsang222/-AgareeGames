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
        window?.rootViewController = CustomUINavigationController(rootViewController: PreGameController(gameTitle: "인물퀴즈"))
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootVC = window.rootViewController as? CustomUINavigationController,
              let topVC = rootVC.topViewController else { return }
        
        if let vc = topVC as? TalkGameController{
            vc.engine?.offEngine()
        }
        if let vc = topVC as? TimerGameCotoller{
            vc.timer?.invalidate()
            vc.timer = nil
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let windowScenne = scene as? UIWindowScene,
              let window = windowScenne.windows.first,
              let rootVC = window.rootViewController as? CustomUINavigationController,
              let topVC = rootVC.topViewController else { return }
        
        if let vc = topVC as? GameController{
            vc.alert(message: "앱이 중지 되었습니다. \n 게임을 다시실행해주세요.", agree: { alert in
                vc.goBackToRoot()
            }, disagree: nil)
        }
    }
}
