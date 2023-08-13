//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit
import AVFoundation
import Speech
import RxSwift


final class PreGameController:BaseController{
    
    
    
//    lazy var preGameView = PreGameView(gameTitle:gameTitle)
    
    
    private var howToPlayView:HowToPlayBaseView?
//    private lazy var authManager = AuthManager(delegate: self)
    
    //MARK: - NaviRoot
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        preGameView.playButton.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        //        configureTempCache()
        configureNaviBar()
//        howToPlayView = configureHowToPlay()
//        preGameView.howToPlayButton.addTarget(self, action: #selector(outerButtonTapped), for: .touchUpInside)
        howToPlayView?.button.addTarget(self, action: #selector(innerButtonTapped), for: .touchUpInside)
    }
    
    init(gameTitle: String) {
//        self.gameTitle = gameTitle
        super.init(nibName: nil, bundle: nil)

        print("🔥🔥🔥")
        print(Global.URL)
        print("🔥🔥🔥")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 설계실수 -> 수정예정 -> 의존성 주입
    @objc private func innerButtonTapped(){
        howToPlayView?.removeFromSuperview()
    }
    
    @objc private func outerButtonTapped(){
        guard let howToPlayView = howToPlayView else { return }
        view.addSubview(howToPlayView)
        NSLayoutConstraint.activate([
            howToPlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            howToPlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            howToPlayView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            howToPlayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        howToPlayView.layoutIfNeeded()
    }
    
    func configureNaviBar(){
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: nil)
    }
    
//    func configureTempCache(){
//        DispatchQueue.global(qos: .userInitiated).async {
//            let files:[URL]
//            files = try! FileManager().contentsOfDirectory(at: Global.PHOTODBURL, includingPropertiesForKeys: nil)
//
//            for element in files{
//                let decoder = JSONDecoder()
//                do{
//                    let data = try Data(contentsOf: element)
//                    let model = try decoder.decode(GuessWhoPlayModel.self, from: data)
//                }catch{
//                    print("--------------  configureTmepCahce")
//                    print(error)
//                    print("--------------  configureTmepCahce")
//                }
//            }
//        }
//    }
    
    
    // 여기서 테스트 해봐야함 se 사이즈
    func configureView(){
//        view.addSubview(preGameView)
//        NSLayoutConstraint.activate([
//            preGameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            preGameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            preGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            preGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
    }
    
    @objc func playButtonTapped(){
//        guard authManager.isMicUsable() else {
//            handleAudioError(err: .AudioOff)
//            return
//        }
//        guard authManager.isSpeechable() else {
//            handleAudioError(err: .SpeechAuth)
//            return
//        }
//        let game = Global.GAMEDIC[gameTitle]!
//        #if DEV
//        let gameClassName = "AgareeGames_dev.\(game)Controller"
//        #else
//        let gameClassName = "AgareeGames_dis.\(game)Controller"
//        #endif
//        let gameClass = NSClassFromString(gameClassName) as! GameController.Type
//        let nextVC = gameClass.init()
//        let title = ((game.first)?.lowercased())! + game.dropFirst()
//        nextVC.gameTitle = title
//        nextVC.howMany = preGameView.segment.selectedSegmentIndex
        
        
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func configureHowToPlay() -> HowToPlayBaseView?{
//        switch gameTitle{
//        case "인물퀴즈":
//            return GuessWhoHTPV()
//        default:
//            break
//        }
        return nil
    }
    
    @objc private func showHowToPlay(){
        guard let howToPlayView = howToPlayView else { return }
        view.addSubview(howToPlayView)
        
        NSLayoutConstraint.activate([
            howToPlayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            howToPlayView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            howToPlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            howToPlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension PreGameController:BaseDelegate{
    func handleError(_ error: Error) {
        handleErrors(error: error)
    }
}
