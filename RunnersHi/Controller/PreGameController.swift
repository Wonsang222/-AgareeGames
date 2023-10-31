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
    var bag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNaviBar()
    }
    
    // 버튼 binding main scheduler에서 ..
    func bindViewModel() {
        
        let entrance = rx.viewDidAppear
            .take(1)
            .map{ _ in }
        let buttonTapped = preGameView.playButton.playButton.rx.tap
            .map{ _ in }
                
        Observable.merge([entrance, buttonTapped])
            .withUnretained(self)
            .flatMapLatest { vc -> Observable<[AudioError]> in
                return vc.0.viewModel.permissions
                    .toArray()
                    .asObservable()
                    .catch{ [weak self] err -> Observable<[AudioError]> in
                        self?.handleAudioError(err: err as! AudioError)
                        return .empty()
                    }
            }
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.sceneCoordinator
            })
            .disposed(by:bag)
        
        
        viewModel.gameTitle
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] title in
                guard let self = self else { return }
                let targetView = self.preGameView
                targetView.titleLabel.text = title
                targetView.titleLabel.updateLabelFontSize(view: targetView.labelContainerView)
            })
            .disposed(by: bag)
        
        
        // checker 
        preGameView.segment.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] idx in
                self?.viewModel.updateModel(idx)
            })
            .disposed(by: bag)
        
        preGameView.howToPlayButton.rx.tap
            .withUnretained(self)
            .flatMap{ vc in vc.0.viewModel.gameInst.asObservable()}
            .subscribe(onNext: { [weak self] instView in
                self?.showHTPV(instView)
            })
            .disposed(by: bag)
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
