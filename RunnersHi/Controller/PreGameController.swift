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
    
    private let viewModel:PregameViewModel
    private let disposeBag = DisposeBag()
    private let preGameView = PreGameView()

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
        configureNaviBar()
        bindViewModel()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel(){
        viewModel.gameTitle
            .observe(on: MainScheduler.instance)
            .bind(to: preGameView.titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindUI(){
        preGameView.segment.rx.selectedSegmentIndex
            .bind(to: viewModel.changePlayerTrigger)
            .disposed(by: disposeBag)
        
        preGameView.titleLabel.rx.methodInvoked(#selector(setter: UILabel.text))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self, weak preGameView] _ in
                preGameView?.titleLabel.updateLabelFontSize(view: (self?.preGameView.labelContainerView)!)
            })
            .disposed(by: disposeBag)
        
        preGameView.howToPlayButton.rx.tap
            .withLatestFrom(viewModel.gameInstruction)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { inst in
                self.showHTPV(inst)
            })
            .disposed(by: disposeBag)
//        
//        preGameView.howToPlayButton.rx.tap
//            .withLatestFrom(viewModel.gameModel)
//            .observe(on: MainScheduler.instance)
//            .bind(to: )
//            .disposed(by: disposeBag)
    }

    @objc private func dissmissHTPV(_ htpv:HowToPlayBaseView){
        htpv.superview!.removeFromSuperview()
    }
    
    @objc private func showHTPV(_ htpv:HowToPlayBaseView){
        view.addSubview(htpv)
        NSLayoutConstraint.activate([
            htpv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            htpv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            htpv.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            htpv.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])

        htpv.layoutIfNeeded()
        htpv.button.addTarget(self, action: #selector(dissmissHTPV(_:)), for: .touchUpInside)
    }
    
    private func configureNaviBar(){
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: nil)
    }

    private func configureView(){
        view.addSubview(preGameView)
        NSLayoutConstraint.activate([
            preGameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            preGameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            preGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            preGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
