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
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = gameTitle
        label.font = UIFont(name: Global.APPFONT, size: 100)
        label.textColor = .white
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
    
    let howToPlayButton:UIButton = {
       let button = UIButton()
        let attributes1:[NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 16),
                                                       .foregroundColor:UIColor.systemGray]
        let attributes2:[NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 16),
                                                       .foregroundColor:UIColor.white]
        let attText1 = NSAttributedString(string: "게임방법이 궁금하신가요?", attributes: attributes1)
        let attText2 = NSAttributedString(string: "좋습니다", attributes: attributes2)
        button.setAttributedTitle(attText1, for: .normal)
        button.setAttributedTitle(attText2, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Button
    private let buttonLabel:UILabel = {
        let label = UILabel()
        label.text = "플레이"
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    private let buttonImage:UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "play.fill")
        iv.tintColor = .white
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let playButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [buttonImage, buttonLabel])
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .center
        st.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        st.isLayoutMarginsRelativeArrangement = true
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    let containerView:UIView = {
       let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func configureSeg(){
        addSubview(segment)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            segment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
        ])
    }
    
    private func configureButton(){
        addSubview(containerView)
        containerView.addSubview(buttonStack)
        containerView.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            
            playButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            playButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            playButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: playButton.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: playButton.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: playButton.trailingAnchor),
            
            buttonImage.widthAnchor.constraint(equalTo: buttonStack.widthAnchor, multiplier: 0.5),
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 200),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
            
        ])
    }
    
    private func configureLabel(){
        addSubview(titleLabel)
        addSubview(howToPlayButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            howToPlayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            howToPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.width / 2
        let centerY = bounds.midY
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerY / 2).isActive = true
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
