//
//  IntroView.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/27.
//

import UIKit

final class IntroView: BaseView {
    
    final let imgView:UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .systemBlue
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let button:UIButton = {
       let button = UIButton()
        button.setTitle("test", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: imgView.bottomAnchor)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
