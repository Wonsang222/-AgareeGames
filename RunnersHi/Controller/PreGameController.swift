//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit

final class PreGameController:SettingController{
    
    let gameTitle:String
    var howManyPlayer:Int?
    
    lazy var preGameView = PreGameView(gameTitle:gameTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        preGameView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        configureTempCache()
    }
    
    init(gameTitle: String) {
        self.gameTitle = gameTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                    print(error)
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
            var game = gameTitle
            let capitalGamename = gameTitle.uppercased()
            let first = capitalGamename.prefix(1)
            game.removeFirst()
            game.insert(contentsOf: first, at: game.startIndex)
            let gameClassName = "AgareeGames.\(game)Controller"
            let gameClass = NSClassFromString(gameClassName) as! GameController.Type
            let nextVC = gameClass.init()
            let emptyVC = EmptyController()
            nextVC.gameTitle = gameTitle
            nextVC.howMany = howManyPlayer
            navigationController?.pushViewController(nextVC, animated: true)
            if var naviStack = navigationController?.viewControllers, let index = naviStack.firstIndex(of: nextVC){
                naviStack.insert(emptyVC, at: index)
                navigationController?.viewControllers = naviStack
            }
        }
    }
