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
            introView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            introView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            introView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        introView.button.addTarget(self, action: #selector(buttontap), for: .touchUpInside)
        
        let base = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setPath("guessWho")
            .setParams("num", 5)
            .build()
            
        Task{
            do{
                try await viewmodel?.fetchDummyNetworkData(httpbaseResource: base)
            } catch{
                print(error)
                goBackToRoot()
            }
        }
    }
    
    @objc func buttontap(){
        print(12312312)
        var num = 0
        num += 1
         introView.imgView.image = viewmodel?.playModelArray[num].photo
        introView.imgView.layoutIfNeeded()
    }
}


