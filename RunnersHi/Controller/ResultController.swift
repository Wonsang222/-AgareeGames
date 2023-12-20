//
//  ResultController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

// 일단 땡! 이걸로 하고 업데이트 할때, 테이블뷰 컨트롤러 사용 및 오답 정리

import UIKit

@available(iOS 16.0, *)
final class ResultController:BaseController {
    
    var viewmodel:ResultViewModel!
    
    let resultLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBackBtn()
        
        


    }
    
    private func configureBackBtn() {
        var backButton = UIBarButtonItem(title: "처음으로", style: .done, target: nil, action: nil)
        backButton.rx.action = viewmodel.popAction
//        navigationItem.backBarButtonItem = backButton
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureUI() {
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
