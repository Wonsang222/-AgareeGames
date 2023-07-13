//
//  PreGameView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

final class PreGameView:BaseView{
    
    let gameTitle:String

    // Font Size 바꿈 -> method 사용
    //MARK: - TitleLabel
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = gameTitle
//        label.updateLabelFontSize(view: <#T##UIView#>)
        label.textColor = .white
        label.backgroundColor = .white
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
    
    let playButton:LabelButton = {
        let button = LabelButton()
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
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
    
    private func configureSeg(){
        addSubview(segment)
        NSLayoutConstraint.activate([
            segment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            segment.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureLabel(){
        addSubview(titleLabel)
        addSubview(howToPlayButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            howToPlayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            howToPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(playButton)
        
//        let centerY = bounds.midY        
        let y = ((howToPlayButton.frame.minY - segment.frame.maxY) / 2) + segment.frame.maxY
        let x = frame.midX
        let height = frame.maxX * 0.3
        let width = height
        playButton.frame = CGRect(x: x, y: y, width: width, height: height)
        playButton.layer.cornerRadius = playButton.frame.width / 2
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(gameTitle:String){
        self.gameTitle = gameTitle
        super.init(frame: .zero)
        configureLabel()
        configureSeg()
    }
}
