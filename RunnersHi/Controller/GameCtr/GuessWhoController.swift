//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx


final class GuessWhoController:GameController {

    //MARK: - Properties
    private let guessView = GuessWhoView()
    var viewModel: GuessWhoViewModel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        progressView.isHidden = false
       
        MyTimer.shared.time
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] time in
                self?.progressView.progress = Float(time)
            })
            .disposed(by: rx.disposeBag)
        
//        rx.viewDidAppear
//            .map{ _ in }
//            .take(1)
//            .subscribe(MyTimer.shared.starting)
//            .disposed(by: rx.disposeBag)
        
        MyTimer.shared.repeater
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        
        
       
        
        
        
        
        
        
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

