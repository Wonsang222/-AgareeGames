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
    private let guessView = GuessWhoView()
    private var engine:STTEngine!
    private lazy var viewModel = GuessWhoViewModel(delegate: self)
    private var answer = ""{
        didSet{
            checkTheProcess()
        }
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        viewModel.setDummyModel()
        engine = STTEngineFactory.create(self)
        guessView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureUI()
        startCounter {
            self.startGame()
        }
    }
    //MARK: - Methods
    func configureUI(){
        view.addSubview(guessView)
        guessView.addSubview(countView)
            
        NSLayoutConstraint.activate([
            guessView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guessView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            guessView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guessView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            countView.centerXAnchor.constraint(equalTo: guessView.centerXAnchor),
            countView.centerYAnchor.constraint(equalTo: guessView.centerYAnchor),
            countView.heightAnchor.constraint(equalToConstant: 200),
            countView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func buttonTapped(){
        engine.runRecognizer { result in
            switch result{
            case .success(let res):
                self.answer += res
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @objc private func startGameTimer(){
        numToCount = numToCount! - 1
        if numToCount == 0{
            timer?.invalidate()
            timer = nil
        }
        Thread.sleep(forTimeInterval: 1)
    }
    
    func startGame(){
        print(44)
        self.countView.removeFromSuperview()
        self.guessView.imageView.isHidden = false
        self.countView.layoutIfNeeded()
        self.viewModel.next()
        print(4.5)
        print(self.viewModel.getTargetModel)
    }
    
    func checkTheAnswer()->Bool{
        guard let targetName = viewModel.getTargetModel?.name else {return false}
        let answer = answer.components(separatedBy: " ").joined()
        if answer.contains(targetName){
            return true
        }
        return false
    }
    
    func checkTheProcess(){
        //정답 맞춘경우
        if checkTheAnswer(){
            viewModel.next()
        } else{
            clearGame(isWin: false)
        }
    }
}

//MARK: - Extension
extension GuessWhoController:SFSpeechRecognizerDelegate{
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
    }
}

extension GuessWhoController:GuessWhoViewModelDelegate{
    func setNextTarget(with data: GuessWhoDataModel) {
        // transition 처리
        print(77)
        guard let targetModel = viewModel.getTargetModel else {
            print(88)
            return}
        print(99)
        guessView.imageView.image = UIImage(systemName: targetModel.photo)
        self.guessView.imageView.layoutIfNeeded()
    }
    
    func clearGame(isWin:Bool) {
        let nextVC = ResultController(isWin: isWin)
        present(nextVC, animated: true)
    }
}
