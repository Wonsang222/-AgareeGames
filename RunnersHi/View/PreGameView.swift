//
//  PreGameView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

class PreGameView:BaseView{
    
    let buttonLabel:UILabel = {
       let label = UILabel()
        let string = "플레이"
        let attributes:[NSAttributedString.Key:Any] = [
            .foregroundColor:UIColor.white,
            .font:UIFont.boldSystemFont(ofSize: 20),
        ]
        label.attributedText = NSAttributedString(string: string, attributes: attributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let buttonImage:UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "play.fill")
        iv.tintColor = .white
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var playButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [buttonImage, buttonLabel])
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .center
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var containerView:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let segment:UISegmentedControl = {
       let seg = UISegmentedControl()
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.addSubview(buttonStack)
        addSubview(containerView)
        addSubview(playButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 150),
            containerView.widthAnchor.constraint(equalToConstant: 150),
            
            buttonImage.widthAnchor.constraint(equalTo: buttonStack.widthAnchor, multiplier: 0.5),
            buttonImage.heightAnchor.constraint(equalTo: buttonStack.heightAnchor, multiplier: 0.5),
            buttonImage.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 15),
            
            buttonStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            playButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            playButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            playButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.width / 2
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
