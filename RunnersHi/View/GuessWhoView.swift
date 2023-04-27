//
//  GuessWhoView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/04/26.
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
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let txtView:UITextView = {
       let txtView = UITextView()
        txtView.text = "sample"
        txtView.textColor = .black
        txtView.tintColor = .black
        txtView.isSelectable = false
        txtView.isEditable = false
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        [imageView, txtView].forEach {addSubview($0)}
        let viewHeight = UIScreen.main.bounds.size.height * 0.3
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: viewHeight),
            imageView.widthAnchor.constraint(equalToConstant: viewHeight),
            
            txtView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            txtView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            txtView.heightAnchor.constraint(equalToConstant: 50),
            txtView.widthAnchor.constraint(equalToConstant: 50)
//            txtView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20)
        ])
    }
}
