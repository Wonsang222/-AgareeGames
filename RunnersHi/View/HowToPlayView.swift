//
//  HowToPlayView.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/20.
//

import UIKit

class HowToPlayBaseView:BaseView{
    
    let mainTitle:UILabel = {
       let label = UILabel()
        let attributedText = NSAttributedString(string: "게임방법", attributes: [.font : UIFont(name: Global.APPFONT, size: 30)!, .foregroundColor:UIColor.black])
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let button:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
