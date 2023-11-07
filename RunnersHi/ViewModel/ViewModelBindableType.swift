//
//  ViewModelBindableType.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/08/12.
//

import UIKit

protocol ViewModelBindableType{
    associatedtype ViewModelType
    
    var viewModel:ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self:BaseController{
    mutating func bind(viewmodel:ViewModelType){
        self.viewModel = viewmodel
        
        loadViewIfNeeded()
        // _ = vc.view 이렇게 해도 동일한 효과 -> viewcontroller의 view는 lazy하게 생김
        
        bindViewModel()
    }
}

