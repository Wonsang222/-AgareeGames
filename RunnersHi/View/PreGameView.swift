//
//  PreGameView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

final class PreGameView:BaseView{
    
    let gameTitle:String
    
    //MARK: - TitleLabel
    lazy var titleLabel:UILabel = {
        let label = CustomLabel(messageText: gameTitle, textSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - SegmentControl
    let segment:UISegmentedControl = {
       let sc = UISegmentedControl(items: ["2인", "3인", "4인", "5인"])
        sc.tintColor = .white
        sc.selectedSegmentTintColor = .systemBlue
        let font = UIFont(name: Global.APPFONT, size: 13)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font:font as Any], for: .selected)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font:font as Any], for: .normal)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    
    //MARK: - Button
    let buttonLabel:UILabel = {
        let label = CustomLabel(messageText: "플레이", textSize: 20.0)
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
        view.backgroundColor = .systemBlue
        return view
    }()
    
    func configureSeg(){
        addSubview(segment)
        NSLayoutConstraint.activate([
            segment.centerXAnchor.constraint(equalTo: centerXAnchor),
            segment.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            segment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func configureButton(){
        containerView.addSubview(buttonStack)
        addSubview(containerView)
        containerView.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            
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
    
    func configureLabel(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.width / 2
        let centerX = bounds.midX
        let centerY = bounds.midY
        containerView.frame = CGRect(origin: CGPoint(x: centerX - (130 / 2), y: centerY), size: CGSize(width: 130, height: 130))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(gameTitle:String){
        self.gameTitle = gameTitle
        super.init(frame: .zero)
        configureLabel()
        configureSeg()
        configureButton()
    }
}
