//
//  GuessWhoController.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import UIKit
import Speech
/*
 timer 없애기...
 기능 붙이기
 */

final class GuessWhoController:GameController{
    
    //MARK: - Properties
    private let guessView = GuessWhoView()
    private var engine:STTEngine?
    private lazy var viewModel = GuessWhoViewModel(delegate: self)
    
    override var numToCount: Float{
        didSet{
            guard numToCount >= 1.0 else { return }
            timer?.invalidate()
            timer = nil
            timerNumber -= 1
            clearGame(isWin: false)
        }
    }
    private var answer = ""{
        didSet{
            guard answer == "" else { return }
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
        guard let engine = self.engine else { return }
        engine.resetRecognizer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setDummyModel()  // 여기서 시간끌기 -> 시간은 충분하다 만약 안되었다면 시간끌기 창 올린다
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
//        countView.removeFromSuperview()
//        guessView.imageView.isHidden = false
//        countView.layoutIfNeeded()
//        viewModel.next()
//        runRecognizer()
        setTimer(3.5, repeater: true)
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
        let answer = answer.components(separatedBy: " ").joined()
        if answer.contains(targetName){
            return true
        }
        return false
    }
    
    private func checkTheProcess(){
        //정답 맞춘경우
        guard let engine = self.engine else { return }
        if checkTheAnswer(){
            timer?.invalidate()
            timer = nil
            engine.resetRecognizer()
            viewModel.next()
        } else{
            clearGame(isWin: false)
        }
    }
    
    override func startGameTimer() {
        numToCount += self.speed
          progressView.setProgress(numToCount, animated: true)
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
        runRecognizer()
        self.guessView.imageView.image = UIImage(systemName: data.photo)
        self.guessView.imageView.layoutIfNeeded()
    }
    
    func clearGame(isWin:Bool) {
        let nextVC = ResultController(isWin: isWin)
        present(nextVC, animated: true)
    }
}
