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
    }
    
    init(gameTitle: String) {
        self.gameTitle = gameTitle
        super.init(nibName: nil, bundle: nil)
        print(className())
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
    
    @objc func playButtonTapped(_ sender:UIButton){
        // nsclassfromStrng 으로 게임을 찾음.
//        let test = test.className()
//        let type2 = NSClassFromString(test) as! UIViewController.Type
//        let vc = type2.init()
//        present(vc, animated: true)
        
    
    }
    
    final func className() -> String{
        return String(reflecting: Self.self)
    }
}
