//
//  HowToPlayView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/11.
//

import UIKit

final class HowToPlayView:BaseView{
    
    let mainTitle:UILabel = {
       let label = UILabel()
        let attributedText = NSAttributedString(string: "게임방법", attributes: [.font : UIFont(name: Global.APPFONT, size: 30)!, .foregroundColor:UIColor.black])
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack:UIStackView = {
       let st = UIStackView()
        st.axis = .vertical
        st.distribution = .fill
        st.spacing = 20
        st.backgroundColor = .systemBlue
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    let button:UIButton = {
        let button = UIButton(type: .custom)
        
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        configureImgView()
        configureStack()
        addSubview(mainTitle)
        addSubview(stack)

        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            mainTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            stack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            stack.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 50),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStack(){
        let attributes:[NSAttributedString.Key:Any] = [.font:UIFont(name: Global.APPFONT, size: 15)!, .foregroundColor:UIColor.white]

        ["가끔식 조커 카드가 나옵니다. \n조커! 라고 외쳐주세요","시간제한 5초", "정확한 이름을 외쳐주세요!","한번이라도 틀리면 게임종료!"].forEach{
            let innerLabel:UILabel = {
               let label = UILabel()
                label.numberOfLines = 0
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            let innerView:UIView = {
               let view = UIView()
                view.backgroundColor = .red
                view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            innerLabel.attributedText = NSAttributedString(string: $0, attributes: attributes)
            innerView.addSubview(innerLabel)
            NSLayoutConstraint.activate([
                innerLabel.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
                innerLabel.centerYAnchor.constraint(equalTo: innerView.centerYAnchor)
            ])
            stack.addArrangedSubview(innerView)
        }

    }
    
    private func configureImgView(){
        let imgView:UIImageView = {
           let img = UIImageView()
            img.image = UIImage(named: "joker")!
            img.contentMode = .scaleAspectFit
            img.translatesAutoresizingMaskIntoConstraints = false
            return img
        }()
      
        stack.addArrangedSubview(imgView)
        imgView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.5).isActive = true
        
    }
}
