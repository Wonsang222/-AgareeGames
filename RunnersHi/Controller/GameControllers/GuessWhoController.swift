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
 과도한 weak self??  -> 알아보기
 progress bar 위치 재지정
 
 에러 리스트
1. audio off 일때 -> 시작 ㄴㄴ 뒤로 가자
 
 */

final class GuessWhoController:TalkGameController{
    
    //MARK: - Properties
    private let guessView = GuessWhoView()
    private lazy var viewModel = GuessWhoViewModel(delegate: self)

    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = STTEngine(controller: self)
        
        let base = ResourceBuilder.shared
            .setReqMethod(.GET)
            .setPath("guessWho")
            .setParams("num", 5)
            .build()
        
//        viewModel.fetchDummyNetworkData(httpbaseResource: base)
        
        configureUI()
//        startCounter {
//            self.startGame()
//        }

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
        if !viewModel.isNetworkDone{
            loaderON()
        }
        countView.removeFromSuperview()
        guessView.imageView.isHidden = false
        countView.layoutIfNeeded()
        viewModel.next()
    }
    
    override func checkTheAnswer()->Bool{
        guard let targetName = viewModel.getTargetModel?.name else { return false }
        print(targetName)   
        let answer = answer.components(separatedBy: " ").joined()
        if answer.contains(targetName){
            return true
        }
        return false
    }
    
    override func checkTheProcess(){
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
    func handleError(_ error: Error) {
        switch error{
        case is NetworkError:
            alert(message: "현재 서버와 연결할 수 없습니다. 양해부탁드립니다.", agree: {[weak self] alert in
                self?.goBackToRoot()
            }, disagree: nil)
        case is AudioError:
            alert(message: "Audio 오류 발생했습니다.", agree: { [weak self] alert in
                self?.terminateAppGracefullyAfter(second: 0)
            }, disagree: nil)
        default:
            showAppTerminatingAlert()
        }
    }
    
    func setNextTarget(with data: GuessWhoPlayModel) {
        // transition 처리
//        setTimer(Global.GAMESPEED, repeater: true)
        answer = ""
        self.guessView.imageView.image = data.photo
        self.guessView.imageView.layoutIfNeeded()
    }
    
    func clearGame(isWin:Bool) {
        print(#function)
        //        let nextVC = ResultController(isWin: isWin)
        // 이게 계속됨... present안되겟다
        if isWin{
            print("클리어~")
        } else{
            print("땡!")
        }
    }
}

extension GuessWhoController:STTEngineDelegate{
    func runRecognizer(_ text: String) {
        self.answer += text
    }
}
