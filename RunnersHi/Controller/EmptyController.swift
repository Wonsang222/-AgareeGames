//
//  EmptyController.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/09.
//

import UIKit

class EmptyController:BaseController{
    
    let imgView:UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        goBackToRoot()
        
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let base = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setPath("guessWho")
            .setParams("num", 3)
            .build()
    
                let configuration = URLSessionConfiguration.default
                configuration.httpAdditionalHeaders = ["Authorization":Global.UUID, "User-Agent": Global.BUNDLEIDENTIFIER]
                let url = "http://localhost:8080/photos/0".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(url)
                let req = URLRequest(url: URL(string:url!)!)
        
        URLSession(configuration: configuration).dataTask(with: req) { data, resp, err in
            if err != nil{
                print(err!)
                return
            }
            
            if let resp = resp {
                guard let a = resp as? HTTPURLResponse else {return}
                let bb = a.allHeaderFields
                let cc = bb["target-name"]
                
                print(cc.debugDescription.removingPercentEncoding)
            }
            DispatchQueue.main.async {
                print("23232")
                print(data)
                self.imgView.image = UIImage(data: data!)
                self.imgView.layoutIfNeeded()
            }
        }.resume()

    }
}
