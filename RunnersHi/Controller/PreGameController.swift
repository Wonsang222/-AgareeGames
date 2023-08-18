//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit
import AVFoundation
import Speech
import RxSwift


final class PreGameController:BaseController{
    
    let viewModel:PregameViewModel
    private let disposeBag = DisposeBag()
    let pregameView = PreGameView()
    

//    private var howToPlayView:HowToPlayBaseView?
//    private lazy var authManager = AuthManager(delegate: self)
    
    //MARK: - NaviRoot
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    init(viewModel:PregameViewModel = PregameViewModel(game: .GuessWho)){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        preGameView.playButton.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        //        configureTempCache()
        configureNaviBar()
//        howToPlayView = configureHowToPlay()
//        preGameView.howToPlayButton.addTarget(self, action: #selector(outerButtonTapped), for: .touchUpInside)
//        howToPlayView?.button.addTarget(self, action: #selector(innerButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(){
        
    }
    
    func bindUI(){
        self.pregameView.segment.rx.selectedSegmentIndex
            
    }
    
    // 설계실수 -> 수정예정 -> 의존성 주입
    @objc private func innerButtonTapped(){
//        howToPlayView?.removeFromSuperview()
    }
    
    @objc private func outerButtonTapped(){
//        guard let howToPlayView = howToPlayView else { return }
//        view.addSubview(howToPlayView)
//        NSLayoutConstraint.activate([
//            howToPlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            howToPlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            howToPlayView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
//            howToPlayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
//        ])
//
//        howToPlayView.layoutIfNeeded()
    }
    
    func configureNaviBar(){
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: nil)
    }

    func configureView(){
//        view.addSubview(preGameView)
//        NSLayoutConstraint.activate([
//            preGameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            preGameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            preGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            preGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
    }
            
    @objc private func showHowToPlay(){
//        guard let howToPlayView = howToPlayView else { return }
//        view.addSubview(howToPlayView)
//
//        NSLayoutConstraint.activate([
//            howToPlayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
//            howToPlayView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
//            howToPlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            howToPlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
    }
}

extension PreGameController:BaseDelegate{
    func handleError(_ error: Error) {
        handleErrors(error: error)
    }
}
