//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import RxSwift
import RxCocoa


final class GuessWhoController:GameController {

    //MARK: - Properties
    private let guessView = GuessWhoView()
    var viewModel: GuessWhoViewModel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        progressView.isHidden = false
        
        
        rx.viewDidAppear
            .take(1)
            .flatMap{ _ in STTEngineRX.shared.startEngine()  }
            .flatMap{ _ in STTEngineRX.shared.runRecognizer() }
        
        
        
        
    }
    
    
    func bindViewModel() {
        
        
    }
    
    

    
    //MARK: - Methods
    private func configureUI(){
        view.addSubview(guessView)
        guessView.addSubview(countView)
        guessView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            guessView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guessView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            guessView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guessView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            countView.centerXAnchor.constraint(equalTo: guessView.centerXAnchor),
            countView.centerYAnchor.constraint(equalTo: guessView.centerYAnchor),
            countView.heightAnchor.constraint(equalToConstant: 200),
            countView.widthAnchor.constraint(equalToConstant: 200),

            progressView.widthAnchor.constraint(equalTo: guessView.widthAnchor, multiplier: 0.5),
            progressView.heightAnchor.constraint(equalToConstant: 20),
            progressView.centerXAnchor.constraint(equalTo: guessView.centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    private func startGame(){
//        if !viewModel.isNetworkDone{ loaderON() }
//        countView.removeFromSuperview()
//        guessView.imageView.isHidden = false
//        progressView.isHidden = false
        
//        countView.layoutIfNeeded()
//        if let serverErr = viewModel.networkErr{
//            handleErrors(error: serverErr)
//        }
//        viewModel.next()
    }

}

