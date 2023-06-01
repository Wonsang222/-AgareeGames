//
//  IntroController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/25.
//

import UIKit

// 아가리 마크

final class IntroController: BaseController, GuessWhoViewModelDelegate {
    func handleError(_: Error) {

    }
    
    func setNextTarget(with data: GuessWhoPlayModel) {
        
    }
    
    func clearGame(isWin: Bool) {
        
    }
    
    let introView = IntroView()
    
    var viewmodel:GuessWhoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        introView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(introView)
        viewmodel = GuessWhoViewModel(delegate: self)
        NSLayoutConstraint.activate([
            introView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            introView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            introView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        introView.button.addTarget(self, action: #selector(buttontap), for: .touchUpInside)
//
//        let model = GuessWhoPlayModel(name: "kaka", photo: UIImage(named: "joker")!, url: "asdfdsaf")
//
//        do{
//            let targetUrl = Global.PHOTODBURL.appendingPathComponent("temp").appendingPathExtension("json")
//
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(model)
//            try data.write(to: targetUrl)
//
//        }catch{
//            print(error)
//        }
        
        
    }
    
    @objc func buttontap(){

    }
}


