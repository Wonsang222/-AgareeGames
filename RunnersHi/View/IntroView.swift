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
        
        imgView.frame = self.bounds
        addSubview(imgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
