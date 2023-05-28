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
    }
    
    init(gameTitle: String) {
        self.gameTitle = gameTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let base = "AgareeGames."
        var game = gameTitle
        let capitalGamename = gameTitle.uppercased()
        var first = capitalGamename.prefix(1)
        game.removeFirst()
        game.insert(contentsOf: first, at: game.startIndex)
        let controller = "Controller"
        let gameClassName = base + game + controller
        let gameClass = NSClassFromString(gameClassName) as! GameController.Type
        let nextVC = gameClass.init()
        nextVC.gameTitle = gameTitle
        nextVC.howMany = howManyPlayer
        // 이거 바꿔야함 push 로
        present(nextVC, animated: true)
    }
}
