//
//  HowToPlayView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/11.
//

import UIKit

final class HowToPlayView:BaseView{
    
    let mainTitle:UILabel = {
       let label = UILabel()
//        let attributes:[NSAttributedString.Key:Any] = [.font:UIFont(name: "게임규칙", size: 20), .foregroundColor:UIColor.white]
//        label.attributedText = NSAttributedString(string: "게임규칙", attributes: attributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [])
        st.axis = .horizontal
        st.distribution = .equalSpacing
        st.alignment = .center
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainTitle)

        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            mainTitle.centerXAnchor.constraint(equalTo: centerXAnchor),

        ])

        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
}
