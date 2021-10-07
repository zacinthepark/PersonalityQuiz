//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by zac on 2021/10/04.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
}

extension ResultsViewController {
    func calculatePersonalityResult() {
        //Calculate Answer Frequency
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map {$0.type}
        //Answer들의 array인 responses에서 각 Answer의 type(dog, cat, rabbit, turtle)들의 array인 responseTypes로 새로 변형(mapping). 형식은 trailing closure로 간소화. $0는 해당 클로저에서 첫 argument라는 뜻.
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        //frequencyOfAnswers[response]에 responseTypes라는 AnimalType들을 대입. 반환하는 값은 해당 type에 대한 응답 횟수. 우측의 ??는 Nil-Coalescing Operation. 만약 이미 응답 횟수가 'Dog: 1'과 같이 이미 기록된 것이라면 1을 반환. 만약 아직 기록되지 않은(nil) key라면 해당 key에 0이라는 값을 줌. 그리고 해당 값에 1을 더해준다.
        }
        
        //Determine the Most Frequent Answers
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        //frequentAnswersSorted는 frequencyOfAnswers라는 dictionary에 각 answer type별 횟수를 계산한 후 해당 dictionary를 'sorted'라는 method를 통해 재정렬한 것이다. 재정렬한 frequentAnswersSorted는 dictionary가 아닌 dictionary의 (key, value)를 튜플로 갖는 array이다(order에 관한 것이기에).
        //해당 메서드의 흐름은 1)sorted 메서드의 파라미터인 클로저가 각 (key, value) pair를 가지고 와서, pair의 value들을 비교, 그리고 더 큰지 작은지에 대한 Boolean값을 반환 ----> 해당 Bool값을 sorted 함수가 받아서, 정렬을 한다.
        //위의 과정들을 trailing closure를 이용하여 다음과 같이 간단하게 표현할 수 있다.
        //let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        //$0는 pair1, $1은 pair2를 의미. $0.1은 pair1의 튜플 중 2번째 요소, 즉 (key, value)중 value를 의미.
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
}
