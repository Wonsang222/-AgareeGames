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
    
    let howToPlayButton:UIButton = {
       let button = UIButton()
        let attributes:[NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 16),
                                                       .foregroundColor:UIColor.systemGray]
        let attText = NSAttributedString(string: "게임방법이 궁금하신가요?", attributes: attributes)
        button.setAttributedTitle(attText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Button
    private let buttonLabel:UILabel = {
        let label = CustomLabel(messageText: "플레이", textSize: 20.0)
        return label
    }()
        
    private let buttonImage:UIImageView = {
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
    
    private lazy var buttonStack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [buttonImage, buttonLabel])
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .center
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private lazy var containerView:UIView = {
       let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private func configureSeg(){
        addSubview(segment)
        NSLayoutConstraint.activate([
            segment.centerXAnchor.constraint(equalTo: centerXAnchor),
            segment.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            segment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func configureButton(){
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
            playButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
        ])
    }
    
    private func configureLabel(){
        addSubview(titleLabel)
        addSubview(howToPlayButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            howToPlayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            howToPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.width / 2
        let centerX = bounds.midX
        let centerY = bounds.midY
        containerView.frame = CGRect(origin: CGPoint(x: centerX - (130 / 2), y: centerY + 130), size: CGSize(width: 130, height: 130))
        
        titleLabel.updateLabelFontSize(view: self)
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
