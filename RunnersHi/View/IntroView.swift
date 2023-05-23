//
//  IntroView.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/27.
//

import UIKit

class IntroView: BaseView {
    
    let imgView:UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .systemBlue
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
