# AgareeGames

## ⭐️ 프로젝트 소개


달린 거리와 시간, 소모한 칼로리를 측정할 수 있어요! 

측정한 정보를 편리하게 확인할 수 있습니다!

또한 **친구와 함께 실시간으로 달릴 수 있는** 러닝앱입니다 🏃‍♂️🏃‍♀️

<br/>

⚙️ 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.0-blue)]()
[![rxswift](https://img.shields.io/badge/RxSwift-6.2.0-green)]()
[![firebase](https://img.shields.io/badge/Firebase-8.9.0-red)]()
[![snapkit](https://img.shields.io/badge/SnapKit-5.0.1-yellow)]()

<br/>

## 🌟 프로젝트 주요 기능

> 🔑 Apple 계정을 통해 회원가입, 로그인을 할 수 있어요!
사진


⚒ 아키텍쳐 

### ⏺ MVVM-C & Clean Architecture

<img width="994" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-11-20%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%2010 40 56" src="https://user-images.githubusercontent.com/46087477/145963925-dc66129a-b3e3-4fe8-827c-6ae176e8e610.png">


> **MVVM**
- MVVM을 도입하여 뷰컨트롤러와 뷰는 화면을 그리는 역할에만 집중하고 데이터 관리, 로직의 실행은 뷰모델에서 진행되도록 했습니다.
- UIKit 요소가 없어도 뷰에 보여질 값들을 뷰모델을 단독으로 단위 테스트하여 확인하고 검증할 수 있게 했습니다.

> **Clean Architecture**
- 뷰모델의 비즈니스 로직들을 유즈케이스로, 네트워크나 외부 프레임워크에 대한 요청은 repository로 분리해 각 레이어의 역할을 분명하게 나누었습니다.
- 단위 테스트에서는 서로 의존관계에 있는 레이어들을 Mock 레이어로 제공하여 원하는 조건을 쉽게 테스트 할 수 있도록 했습니다.

> **Coordinator**
- 화면 전환에 대한 로직을 ViewController로부터 분리하고 의존성 객체에 대한 주입을 외부에서 처리하도록 하기 위해 코디네이터를 사용했습니다.

> **Input/Output Modeling**
- 뷰모델을 Input과 Output으로 정의하여 뷰의 이벤트들을 Input에 바인딩하고, 뷰에 보여질 데이터를 Output에 바인딩했습니다.
- 일관성 있고 직관적인 구조를 유지해 뷰모델의 코드 가독성이 높아지고, 테스트 대상을 명확하게 할 수 있도록 했습니다.

<br/>

## 🔥 기술적 도전

### ⏺ RxSwift
- 연속된 escaping closure를 피하고, 선언형 프로그래밍을 통한 높은 가독성과 RX 오퍼레이터를 통한 효율적인 비동기처리를 위해 RxSwift를 사용하게 되었습니다.
- 데이터가 발생하는 시점에서부터 뷰에 그려지기까지 하나의 큰 스트림으로 데이터를 바인딩해주었습니다.

### ⏺ CoreMotion & CoreLocation
- 실시간으로 운동정보를 측정하기 용이한 `CoreMotion` 을 통해 이동거리와 사용자의 현재 상태를 판단해 칼로리를 직접 계산하는 방식을 선택하였습니다.
- 사용자의 이동 경로를 실시간으로 반영하고 좌표값을 저장을 위해 `CoreLocation`을 사용했습니다. distanceFilter 속성을 사용해 어느 정도 이상의 위치 변화가 생겼을 때 좌표 정보를 전달받아 저장하는 방식으로 구현하였습니다.

### ⏺ Firebase를 활용한 실시간 데이터 스트리밍
- 바뀌는 정보를 담을 Entity를 설계했고 immutability를 지키기 위해 새롭게 갱신된 값이 갱신되면 인스턴스를 새롭게 생성하고 변화한 프로퍼티만을 갱신시켜주며 서버와 통신을 했습니다. 
- Firebase의 Realtime Database를 활용해 변경사항을 옵저빙하고, 값이 갱신되면 실시간으로 뷰에 반영하여 상대방의 정보도 확인할 수 있도록 했습니다.

### ⏺ 재사용 가능한 View & ViewController 상속
- 달리기 모드에 따라 화면 구성이 조금씩 차이가 있어 공통적인 부분은 상위 View Controller로부터 상속 받고 다른 구성 요소에 대하여 재정의할 수 있도록 하였습니다.
- 여러 화면에서 공통적으로 사용되는 UI 등은 별도의 Custom Class로 정의하여 View의 재사용성을 높이고자 하였습니다.

### ⏺ Image Cache
- 메모리 캐시와 디스크 캐시를 활용해 이미지의 캐싱을 구현했습니다.
- 디스크 캐시의 경우 서버에 새롭게 올라간 이미지는 ETag를 활용해 새롭게 갱신시켜 주었습니다.

### ⏺  Rx 테스트 코드 작성
- 분리한 아키텍처에서 뷰모델의 Input, Output과 UseCase의 비즈니스 로직등을 테스트했습니다.
- Default(실제 사용하는 로직이 있는), Mock(테스트만을 위한) 두 가지의 객체를 따로 정의해 테스트 코드 작성했습니다
- 그 결과 44개의 테스트에 대해 90% 이상의 커버리지, 전체 코드 커버리지는 30%를 얻을 수 있었습니다. 

<br/>
<br/>

