//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech
/*
 check the process 에서 타이머 멈추는거
 타이머 갯수 확인하자
 tim
 */

final class GuessWhoController:GameController{
    
    //MARK: - Properties
    private let guessView = GuessWhoView()
    private var engine:STTEngine?
    private lazy var viewModel = GuessWhoViewModel(delegate: self)
    private var answer = ""{
        didSet{
            print(answer)
            checkTheProcess()
        }
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        engine?.startEngine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let engine = self.engine else { return }
        engine.offEngine()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setOneModel()
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
        guessView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            guessView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guessView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            guessView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guessView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            countView.centerXAnchor.constraint(equalTo: guessView.centerXAnchor),
            countView.centerYAnchor.constraint(equalTo: guessView.centerYAnchor),
            countView.heightAnchor.constraint(equalToConstant: 200),
            countView.widthAnchor.constraint(equalToConstant: 200),
            
            progressView.widthAnchor.constraint(equalTo: guessView.widthAnchor, multiplier: 0.5),
            progressView.heightAnchor.constraint(equalToConstant: 20),
            progressView.centerXAnchor.constraint(equalTo: guessView.centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: guessView.bottomAnchor, constant: -200)
        ])
    }
    
    private func startGame(){
        runRecognizer()
        //        countView.removeFromSuperview()
        //        guessView.imageView.isHidden = false
        //        countView.layoutIfNeeded()
        viewModel.next()
    }
    
    private func runRecognizer(){
        guard let engine = engine else { return }
        engine.runRecognizer { result in
            switch result{
            case .success(let res):
                self.answer += res
            case .failure(let err):
                print("runRecognizer:\(err)")
            }
        }
    }
    
    private func checkTheAnswer()->Bool{
        guard let targetName = viewModel.getTargetModel?.name else { return false }
        print(targetName)
        let answer = answer.components(separatedBy: " ").joined()
        if answer.contains(targetName){
            return true
        }
        return false
    }
    
    private func checkTheProcess(){
        print(#function)
        //정답 맞춘경우
        if checkTheAnswer(){
            timer?.invalidate()
            timer = nil
            viewModel.next()
            print("마즘")
        }
    }
    override func startGameTimer(_ timer: Timer) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.numToCount >= 1.0 {
                timer.invalidate()
                self.timer = nil
                self.clearGame(isWin: false)
            }
            self.numToCount += self.speed
            self.progressView.setProgress(self.numToCount, animated: true)
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
        setTimer(3.5, repeater: true)
        answer = ""
        self.guessView.imageView.image = UIImage(systemName: data.photo)
        self.guessView.imageView.layoutIfNeeded()
    }
    
    func clearGame(isWin:Bool) {
        print(#function)
        //        let nextVC = ResultController(isWin: isWin)
        // 이게 계속됨... present안되겟다
        if isWin{
            print("right")
        } else{
            print("wrong")
        }
    }
}
