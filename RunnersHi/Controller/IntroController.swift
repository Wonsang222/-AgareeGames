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
    
    func setNextTarget(with data: GuessWhoDataModel) {
        
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
            introView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            introView.heightAnchor.constraint(equalToConstant: 200),
            introView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        let base = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setMultiPart(false)
            .setPath("guessWho")
            .setParams("num", 5)
            .setReqHeader("Authorization", Global.UUID)
            .setReqHeader("User-Agent", Global.BUNDLEIDENTIFIER)
            .build()
            
        Task{
           try await viewmodel?.fetchDummyNetworkData(httpbaseResource:base)
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()

    }
}
