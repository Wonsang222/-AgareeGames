//
//  GameController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

import UIKit
import RxSwift

class GameController:BaseController{
    
    //MARK: - Properties
    
    final let countView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    final let progressView:UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .default
        pv.tintColor = .systemBlue
        pv.isHidden = true
        pv.trackTintColor = .lightGray
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Methods

    lazy var startCounting:Completable =  {
        let imageNames = ["3.circle", "2.circle", "1.circle"]
        return Observable.from(imageNames)
            .withUnretained(self)
            .concatMap { data -> Completable in
                let sub = PublishSubject<Never>()
                let controller = data.0
                let imageName = data.1
                
                UIView.transition(with: controller.countView, duration: 2) {
                    controller.countView.image = UIImage(systemName: imageName)
                    controller.countView.layoutIfNeeded()
                    sub.onCompleted()
                }
                return sub.asCompletable()
            }
            .asCompletable()
    }()
}
