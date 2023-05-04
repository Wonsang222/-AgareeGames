//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech
/*
 navtigation bar color = black
 background color = black
 
 3,2,1 시작 -> audio, request, task start! -> 3,2,1 -> result(단어 있으면 넘어가기) -> 3,2,1
 
 text 필드 변할때마다 호출하는 메서드
 
 뷰모델 셋팅해야함
 
 */

final class GuessWhoController:GameController{
    
    //MARK: - Properties
    private let guessWhoView = GuessWhoView()
    private var engine:STTEngine!
    private let viewModel = GuessWhoViewModel()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guessWhoView.imageView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        engine = STTEngineFactory.create(self)
        guessWhoView.txtView.delegate = self
        viewModel.setDummyModel()
        
//        guessWhoView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTimer(second: 1, selector: #selector(startGameTimer), repeater: true, num: 3)
        configureCounterView()
    }
    
    override func loadView() {
        view = guessWhoView
    }
    
    //MARK: - Methods
    
    private func configureCounterView(){
        guessWhoView.addSubview(countView)
        
        NSLayoutConstraint.activate([
            countView.topAnchor.constraint(equalTo: view.topAnchor),
            countView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            countView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func buttonTapped(){
        engine.runRecognizer { result in
            switch result{
            case .success(let res):
                print(res)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @objc private func startGameTimer(){
        guessWhoView.txtView.text = "\(numToCount!)"
        numToCount = numToCount! - 1
        
        if numToCount == 0{
            guessWhoView.txtView.text = "\(numToCount!)"
            timer?.invalidate()
            timer = nil
        }
        Thread.sleep(forTimeInterval: 1)
    }
    
  
}

//MARK: - Extension
extension GuessWhoController:SFSpeechRecognizerDelegate{
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
    
    }
}

extension GuessWhoController:UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        // 텍스트 뷰 모든 텍스트 검사해야함, 빈칸없음, string indexing
        
    }
}
