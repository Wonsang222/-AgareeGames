//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit
import AVFoundation
import Speech

final class PreGameController:BaseController{
    
    private let gameTitle:String
    lazy var preGameView = PreGameView(gameTitle:gameTitle)
    private var howToPlayView:HowToPlayBaseView?
    
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
        preGameView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        configureTempCache()
        configureNaviBar()
        howToPlayView = configureHowToPlay()
        preGameView.howToPlayButton.addTarget(self, action: #selector(outerButtonTapped), for: .touchUpInside)
        howToPlayView?.button.addTarget(self, action: #selector(innerButtonTapped), for: .touchUpInside)
    }
    
    init(gameTitle: String) {
        self.gameTitle = gameTitle
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
    
    func configureTempCache(){
        DispatchQueue.global(qos: .userInitiated).async {
            let files:[URL]
            files = try! FileManager().contentsOfDirectory(at: Global.PHOTODBURL, includingPropertiesForKeys: nil)
            
            for element in files{
                let decoder = JSONDecoder()
                do{
                    let data = try Data(contentsOf: element)
                    let model = try decoder.decode(GuessWhoPlayModel.self, from: data)
                    TempCache.shared.cache[model.url] = model.photo
                }catch{
                    print("--------------  configureTmepCahce")
                    print(error)
                    print("--------------  configureTmepCahce")
                }
            }
        }
    }
    
    func configureView(){
        view.addSubview(preGameView)
        NSLayoutConstraint.activate([
            preGameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            preGameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            preGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            preGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func playButtonTapped(){
        let game = Global.GAMEDIC[gameTitle]!
        let gameClassName = "AgareeGames_dis.\(game)Controller"
        let gameClass = NSClassFromString(gameClassName) as! GameController.Type
        let nextVC = gameClass.init()
        let title = ((game.first)?.lowercased())! + game.dropFirst()
        nextVC.gameTitle = title
        nextVC.howMany = preGameView.segment.selectedSegmentIndex
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func configureHowToPlay() -> HowToPlayBaseView?{
        switch gameTitle{
        case "인물퀴즈":
            return GuessWhoHTPV()
        default:
            break
        }
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
    
    private func checkMicrophonePermission() {
        let microphoneStatus = AVCaptureDevice.authorizationStatus(for: .audio)
          switch microphoneStatus {
          case .authorized:
              break
          case .restricted:
              alert(message: "현재 디바이스의 마이크 사용이 불가 합니다. \n 5초 후 앱을 종료합니다. ", agree: { [weak self] alert in
                  self?.terminateAppGracefullyAfter(second: 5.0)
              }, disagree: nil)
          case .notDetermined, .denied:
              // 마이크 사용 권한이 아직 결정되지 않은 경우
              AVCaptureDevice.requestAccess(for: .audio) {[weak self] granted in
                  if !granted {
                      self?.alert(message:"마이크 권한수락은 이 앱의 필수입니다. \n 아래의 버튼을 통해 설정으로 이동합니다..", agree: { action in
                          
                          // 설정
                          
                      }, disagree: nil)
                      return
                  }
                  return
              }
          @unknown default:
              break
          }
      }
    
    private func checkSpeechPermission(){
        let authStatus = SFSpeechRecognizer.authorizationStatus()
        
        switch authStatus{
        case .authorized:
            break
        case .denied, .notDetermined:
            print(2)
        case .restricted:
            print(3)
        @unknown default:
            break
        }
    }
    
    
  }
