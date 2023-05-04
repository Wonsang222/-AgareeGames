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
        backgroundColor = .gray.withAlphaComponent(0.9)
        self.layer.opacity = 0.7
        translatesAutoresizingMaskIntoConstraints = false
        
        ["1.circle", "2.circle", "3.circle"].forEach{ (icon) in
            let imgView = UIImageView(image: UIImage(systemName: icon))
            imgView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgView)
        }
        
        startCountDown()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var isFirst = true
        for image in self.subviews.reversed(){
            if isFirst == true{
                image.isHidden = false
                isFirst = false
            } else {
                image.isHidden = true
            }
            
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
            image.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        }
    }
    
    // 트랜지션 보고 다시하기
    func startCountDown(){
//        UIView.transition(with: <#T##UIView#>, duration: <#T##TimeInterval#>, animations: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
