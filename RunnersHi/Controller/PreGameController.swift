//
//  SettingController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import NSObject_Rx

final class PreGameController:BaseController, ViewModelBindableType{

    private let preGameView = PreGameView()
    var viewModel: PregameViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNaviBar()
    }
    
    // 버튼 binding main scheduler에서 ..
    func bindViewModel() {
        
        let firstLoad = rx.viewWillAppear
            .take(1)
            .map{ _ in }
        let buttonTapped = preGameView.playButton.playButton.rx.tap
            .map{ _ in }
        
        viewModel.gameTitle
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] title in
                guard let self = self else { return }
                let targetView = self.preGameView
                targetView.titleLabel.text = title
                targetView.titleLabel.updateLabelFontSize(view: targetView.labelContainerView)
            })
            .disposed(by: rx.disposeBag)
        
        
        // checker 
        preGameView.segment.rx.selectedSegmentIndex
            .debug("checker")
            .subscribe(onNext: { [weak self] idx in
                self?.viewModel.updateModel(idx)
            })
            .disposed(by: rx.disposeBag)
        
        preGameView.howToPlayButton.rx.tap
            .withUnretained(self)
            .flatMap{ vc in vc.0.viewModel.gameInst.asObservable()}
            .subscribe(onNext: { [weak self] instView in
                instView.button.addTarget(self,
                                          action: #selector(self?.dissmissHTPV(_:)),
                                          for: .touchUpInside)
                self?.showHTPV(instView)
            })
            .disposed(by: rx.disposeBag)
        
        preGameView.playButton.playButton.rx.tap
            .withUnretained(self)
            .flatMap{ vc in vc.0.viewModel.permissions }
            .subscribe(onNext: { [weak self] err in
                self?.handleAudioError(err: err)
            })
            .disposed(by: rx.disposeBag)
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
    }
    
    private func configureNaviBar(){
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
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
