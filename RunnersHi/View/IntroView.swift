//
//  IntroView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/04/27.
//

import UIKit

class IntroView: UIView {
    
    let imgView:UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .systemBlue
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: self.topAnchor),
            imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
