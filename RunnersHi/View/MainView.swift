//
//  MainView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/02.
//

import UIKit

class MainView:BaseView{
    
    let stackView:UIStackView = {
       let st = UIStackView()
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .center
        st.spacing = 20
        st.backgroundColor = .green
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ["인물 맞추기", "사자성어"].forEach{buttons in
            let button = UIButton()
            button.setTitle(buttons, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
        }
        addSubview(stackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
        ])
    }
}
