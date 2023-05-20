//
//  BaseView.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/16.
//

import UIKit

class BaseView:UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
