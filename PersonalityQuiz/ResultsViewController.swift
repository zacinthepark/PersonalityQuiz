//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by zac on 2021/10/04.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
    }
}

extension ResultsViewController {
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map {$0.type}
        //Answer들의 array인 responses에서 각 Answer의 type(dog, cat, rabbit, turtle)들의 array인 responseTypes로 새로 변형(mapping). 형식은 trailing closure로 간소화. $0는 해당 클로저에서 첫 argument라는 뜻.
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        //frequencyOfAnswers[response]에 responseTypes라는 AnimalType들을 대입. 반환하는 값은 해당 type에 대한 응답 횟수. 우측의 ??는 Nil-Coalescing Operation. 만약 이미 응답 횟수가 'Dog: 1'과 같이 이미 기록된 것이라면 1을 반환. 만약 아직 기록되지 않은(nil) key라면 해당 key에 0이라는 값을 줌. 그리고 해당 값에 1을 더해준다.
        }
    }
}
