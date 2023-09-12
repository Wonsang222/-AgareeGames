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
        
    //MARK: - NaviRoot
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNaviBar()
    }
    
    func bindViewModel() {

        viewModel.gameTitle
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] title in
                guard let self = self else { return }
                let targetView = self.preGameView
                targetView.titleLabel.text = title
                targetView.titleLabel.updateLabelFontSize(view: targetView.labelContainerView)
            })
            .disposed(by: rx.disposeBag)
        
        preGameView.segment.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] idx in
                self?.viewModel.updateModel(idx)
            })
            .disposed(by: rx.disposeBag)
        
        preGameView.howToPlayButton.rx.tap
            .flatMap{ [weak self] _ in
                return self?.viewModel.gameInst.asObservable() ?? .empty()
            }
            .subscribe(onNext: { [weak self] instView in
                instView.button.addTarget(self, action: #selector(self?.dissmissHTPV(_:)), for: .touchUpInside)
                self?.showHTPV(instView)
            })
            .disposed(by: rx.disposeBag)
        
        let willEnterForeground = NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .flatMapLatest { _ -> Observable<Void> in  // flatMapLatest를 사용
                return AuthManager.checkMicUsable()
                    .andThen(AuthManager.checkSpeechable())
                    .asObservable()
                    .map { _ in }
            }
            .catch({ [unowned self] err in
                self.handleErrors(error: err)
                print("err")
                return Observable.never()  // 스트림을 유지
            })

        let playButtonTapped = preGameView.playButton.playButton.rx.tap
            .flatMapLatest { _ -> Observable<Void> in  // flatMapLatest를 사용
                return AuthManager.checkMicUsable()
                    .andThen(AuthManager.checkSpeechable())
                    .asObservable()
                    .map { _ in }
            }
            .catch({ [unowned self] err in
                self.handleErrors(error: err)
                print("err")
                return Observable.never()  // 스트림을 유지
            })

        Observable.merge(willEnterForeground, playButtonTapped)
            .subscribe(onNext: { [unowned self] in
                print("next")
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
