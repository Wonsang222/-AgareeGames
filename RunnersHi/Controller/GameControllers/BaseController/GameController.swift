//
//  GameController.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

class GameController:BaseController{

    //MARK: - Properties
    
    var gameTitle:String? = nil
    var howMany:Int? = nil

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
        pv.trackTintColor = .lightGray
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()

    //MARK: - Lifecycle
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .partialCurl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard Reachability.networkConnected() else {
            alert(message: "네트워크가 연결되어 있지 않습니다.\n앱을 종료합니다.", agree: { UIAlertAction in
                exit(0)
            }, disagree: nil)
                return
            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    //MARK: - Methods
    
    final func startCounter(handler:@escaping()->Void){
        UIView.transition(with: countView, duration: 2, options: [.transitionFlipFromTop]) {
            self.countView.image = UIImage(systemName: "3.circle")
            self.countView.layoutIfNeeded()
        } completion: { finished in
            UIView.transition(with: self.countView, duration: 2, options: [.transitionFlipFromTop]) {
                self.countView.image = UIImage(systemName: "2.circle")
                self.countView.layoutIfNeeded()
            } completion: { finished in
                UIView.transition(with: self.countView, duration: 2, options: [.transitionFlipFromTop]) {
                    self.countView.image = UIImage(systemName: "1.circle")
                    self.countView.layoutIfNeeded()
                } completion: { finished in
                    handler()
                }
            }
        }
    }
}
