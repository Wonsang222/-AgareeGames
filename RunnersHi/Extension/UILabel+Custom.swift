//
//  UILabel+Custom.swift
//  AgareeGames
//
//  Created by 황원상 on 12/4/23.
//

import UIKit

class DynamicUILabel:UIView {

    private var label:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text:String) {
        label.text = text
        
        let maxFontSize:CGFloat = 150
        let font = UIFont(name: Global.APPFONT, size: maxFontSize)
        self.label.sizeToFit()
        
        while label.bounds.width > self.bounds.width || label.bounds.height > self.bounds.height {
            let currentFonSize = font?.pointSize
            guard let currentFonSize = currentFonSize else { return }
            let newSize = currentFonSize - 1.0
            
            label.font = UIFont(name: Global.APPFONT, size: newSize)
            label.sizeToFit()
        }
    }
}
