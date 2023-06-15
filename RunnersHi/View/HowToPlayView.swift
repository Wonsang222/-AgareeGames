//
//  HowToPlayView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/11.
//

import UIKit

final class HowToPlayView:BaseView{
    
    private let mainTitle:UILabel = {
       let label = UILabel()
        let attributedText = NSAttributedString(string: "게임방법", attributes: [.font : UIFont(name: Global.APPFONT, size: 30)!, .foregroundColor:UIColor.black])
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let button:UIButton = {
        let button = UIButton(type: .custom)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureContainer()
        addSubview(mainTitle)
        addSubview(containerView)

        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            mainTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            containerView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 50),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContainer(){
        let imgView:UIImageView = {
            let imgView = UIImageView(image: UIImage(named: "joker")!.withRenderingMode(.alwaysOriginal))
            imgView.contentMode = .scaleAspectFit
            imgView.translatesAutoresizingMaskIntoConstraints = false
            return imgView
        }()
        
        let descriptionLabel1:UILabel = {
            let label = UILabel()
            label.text = "게임시간은 4초, 기회는 1인당 1번!"
            label.textColor = .black
            // trait이 궁금해진다
            label.font = .preferredFont(forTextStyle: .body)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let descriptionLabel2:UILabel = {
            let label = UILabel()
            label.text = "인물의 이름을 외쳐주세요"
            label.textColor = .black
            // trait이 궁금해진다
            label.font = .preferredFont(forTextStyle: .body)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let descriptionLabel3:UILabel = {
            let label = UILabel()
            label.text = "종종 보너스 카드가 나옵니다.\n 조커!라고 외쳐주세요"
            label.numberOfLines = 2
            label.textColor = .black
            // trait이 궁금해진다
            label.font = .preferredFont(forTextStyle: .body)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    }
}
