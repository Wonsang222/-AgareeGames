//
//  PreGameView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/04.
//

import UIKit

class PreGameView:BaseView{
    let playButton:UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .borderless()
        button.configuration?.buttonSize = .large
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let segment:UISegmentedControl = {
       let seg = UISegmentedControl()
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            playButton.topAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playButton.layer.cornerRadius = playButton.frame.width / 2
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
