//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit

final class PreGameController:SettingController{
    
    let gameTitle:String
    lazy var preGameView = PreGameView(gameTitle:gameTitle)
    
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
        naviroot()
    }
    
    init(gameTitle: String) {
        self.gameTitle = gameTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func naviroot(){
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
    }
