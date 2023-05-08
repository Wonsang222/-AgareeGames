//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech
/*
타이머 구현!!!!!!!! 3.5초 어케하지
 소리로만 할까
 띠 띠 띠
  3 2 1 땡
 
 Progress bar로 일단하자
 
 */

final class GuessWhoController:GameController{
    
    //MARK: - Properties
    private let guessView = GuessWhoView()
    private var engine:STTEngine?
    private lazy var viewModel = GuessWhoViewModel(delegate: self)
    private var answer = ""{
        didSet{
            guard answer == "" else {return}
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
        guard let engine = engine else {return}
        engine.resetRecognizer()
    }
    
    override func viewDidLoad() {
        viewModel.setDummyModel()
        engine = STTEngineFactory.create(self)
        configureUI()
        startCounter {
            self.startGame()
        }
    }
    //MARK: - Methods
    private func configureUI(){
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
    
    private func runRecognizer(){
        guard let engine = engine else {return}
        engine.runRecognizer { result in
            switch result{
            case .success(let res):
                self.answer += res
            case .failure(let err):
                print("runRecognizer:\(err)")
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
    
    private func startGame(){
        self.countView.removeFromSuperview()
        self.guessView.imageView.isHidden = false
        self.countView.layoutIfNeeded()
        self.viewModel.next()
        runRecognizer()
    }
    
    private func checkTheAnswer()->Bool{
        guard let targetName = viewModel.getTargetModel?.name else {return false}
        let answer = answer.components(separatedBy: " ").joined()
        if answer.contains(targetName){
            return true
        }
        return false
    }
    
    private func checkTheProcess(){
        //정답 맞춘경우
        guard let engine = engine else {return}
        if checkTheAnswer(){
            engine.resetRecognizer()
            answer = ""
            runRecognizer()
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
        guessView.imageView.image = UIImage(systemName: data.photo)
        self.guessView.imageView.layoutIfNeeded()
    }
    
    func clearGame(isWin:Bool) {
        let nextVC = ResultController(isWin: isWin)
        present(nextVC, animated: true)
    }
}
