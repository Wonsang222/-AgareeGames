//
//  ResultController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/04.
//

// 일단 땡! 이걸로 하고 업데이트 할때, 테이블뷰 컨트롤러 사용 및 오답 정리

import UIKit

final class ResultController:SettingController{
    
    var isWin:Bool
    
    let resultLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmptyController()
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        resultLabel.updateLabelFontSize(view: view)
    }
    
    init(isWin: Bool) {
        self.isWin = isWin
        super.init(nibName: nil, bundle: nil)
        checkTheResult()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkTheResult(){
        if isWin{
            resultLabel.text = "통과~!"
        } else {
            resultLabel.text = "땡~!"
        }
    }
    
    func configureEmptyController(){
        if var stack = navigationController?.viewControllers, let index = stack.firstIndex(of: self){
            print(stack)
            print(index)
            stack.insert(EmptyController(), at: index)
            navigationController?.viewControllers = stack
        }
    }
    
    deinit{
        print("---------------")
        print("off result")
        print("---------------")
    }
}
