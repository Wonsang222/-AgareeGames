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

class CustomLabel:UILabel{
    
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
