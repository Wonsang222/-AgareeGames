//
//  GuessWhoView.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit

class GuessWhoView:UIView{
    
//  textview????
    // 1줄 허용 /. 몇글자 넘어가면 알아서 cut // 헛소리 중에 정답 있으면 check 해야함
    
    let imageView:UIImageView = {
       let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.image = UIImage(systemName: "trash")
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let button:UIButton = {
       let button = UIButton()
        button.setTitle("ready", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        [imageView, button].forEach {addSubview($0)}
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
}
