//
//  GuessWhoView.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

final class GuessWhoView:BaseView{
    
    let imageView:UIImageView = {
       let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.image = UIImage(systemName: "trash")
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        [imageView].forEach {addSubview($0)}
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
        ])
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        configureUI()
//    }
}
