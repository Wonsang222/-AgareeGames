//
//  Extension.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/03.
//

import UIKit

extension String{
    func urlEncode() -> String{
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return escapedString
    }
}

final class CustomLabel:UILabel{
    let messageText:String
    let textSize:CGFloat
    lazy var attributes:[NSAttributedString.Key:Any] = [.foregroundColor:UIColor.white,
                                          .font: UIFont(name: Global.APPFONT, size: textSize) as Any]
    
    init(messageText:String, textSize:CGFloat ){
        self.messageText = messageText
        self.textSize = textSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.attributedText = NSAttributedString(string: messageText, attributes: self.attributes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class textView:UIView{
    let text:String
    lazy var label:UILabel = {
        let label = UILabel()
        label.text = self.text
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(text: String) {
        self.text = text
        super.init()
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        backgroundColor = .black
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabel{
    func updateLabelFontSize(view:UIView){
        let maxSize:CGFloat = 150
        self.font = UIFont(name: Global.APPFONT, size: maxSize)
        self.sizeToFit()
        
        while self.bounds.width > view.bounds.width || self.bounds.height > view.bounds.height{
            let currnetFontSize = self.font.pointSize
            let reducedSize = currnetFontSize - 1.0
            
            if reducedSize < UIFont.labelFontSize{
                break
            }
            
            self.font = UIFont(name: Global.APPFONT, size: reducedSize)
            self.sizeToFit()
        }
    }
}
