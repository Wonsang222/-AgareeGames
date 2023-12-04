//
//  Extension.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/03.
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

final class ViewWithLabel:UIView{
    
    var text:String
    
    lazy var label:UILabel = {
       let label = UILabel()
        let attributes:[NSAttributedString.Key:Any] = [.font:UIFont(name: Global.APPFONT, size: 10), .foregroundColor:UIColor.white]
        let attributedText1 = NSAttributedString(string: text)
        label.attributedText = attributedText1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(text:String){
        self.text = text
        super.init(frame: .zero)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelButton:UIView{
    
    private let buttonLabel:UILabel = {
        let label = UILabel()
        label.text = "플레이"
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    private let buttonImage:UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "play.fill")
        iv.tintColor = .white
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let playButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [buttonImage, buttonLabel])
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .center
        st.layoutMargins = UIEdgeInsets(top: 15,
                                        left: 0,
                                        bottom: 0,
                                        right: 0)
        st.isLayoutMarginsRelativeArrangement = true
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
        addSubview(buttonStack)
        addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: topAnchor),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: playButton.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: playButton.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: playButton.trailingAnchor),
            
            buttonImage.widthAnchor.constraint(equalTo: buttonStack.widthAnchor,
                                               multiplier: 0.5),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
