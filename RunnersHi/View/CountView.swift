//
//  CountView.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/02.
//

import UIKit

class CountView:UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        backgroundColor = .gray.withAlphaComponent(0.8)
        self.layer.opacity = 0.5
        translatesAutoresizingMaskIntoConstraints = false
        
        ["1.circle", "2.circle", "3.circle"].forEach{ (icon) in
            let imgView = UIImageView(image: UIImage(systemName: icon))
            imgView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for i in self.subviews{
            i.frame = self.bounds
        }
    }
}
