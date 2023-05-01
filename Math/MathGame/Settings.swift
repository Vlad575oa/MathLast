//
//  settings.swift
//  SimpleGames
//
//  Created by user on 26.04.2023.
//

import Foundation
//MARK - enum
enum OperationType: String, CaseIterable {
  case addition = "+"
  case subtraction = "-"
  case multiplication = "×"
  case division = "÷"

  var sign: String {
    switch self {
    case .addition:
      return NSLocalizedString("+", comment: "Addition sign")
    case .subtraction:
      return NSLocalizedString("-", comment: "Subtraction sign")
    case .multiplication:
      return NSLocalizedString("×", comment: "Multiplication sign")
    case .division:
      return NSLocalizedString("÷", comment: "Division sign")
    }
  }
}

//MARK - main functions
extension MathView {
  func answerIsCorrect(answer: Int){
    if answer == correctAnswer {
      self.score += 1
    } else {
      self.score -= 1
    }
  }

  func generateAnswers(){

    switch selectedSign {
    case 0: // addition
      firstNumber = Int.random(in: 1...(difficultyArray[difficulty]/2))
      secondNumber = Int.random(in: 1...(difficultyArray[difficulty]/2))
      var answerList = [Int]()
      correctAnswer = firstNumber + secondNumber

      for _ in 0...2 {
        answerList.append(Int.random(in: 1...difficultyArray[difficulty]))
      }
      answerList.append(correctAnswer)
      choiceArray = answerList.shuffled()

    case 1: // subtraction
      firstNumber = Int.random(in: 1...(difficultyArray[difficulty]/2))
      secondNumber = Int.random(in: 1...firstNumber) // second number must be less than or equal to the first number
      var answerList = [Int]()
      correctAnswer = firstNumber - secondNumber

      for _ in 0...2 {
        answerList.append(Int.random(in: 1...difficultyArray[difficulty]))
      }
      answerList.append(correctAnswer)
      choiceArray = answerList.shuffled()
    case 2: // multiplication
      firstNumber = Int.random(in: 1...(difficultyArray[difficulty]/5)) // limit first number to make it easier
      secondNumber = Int.random(in: 1...10)
      var answerList = [Int]()
      correctAnswer = firstNumber * secondNumber

      for _ in 0...2 {
        answerList.append(Int.random(in: 1...difficultyArray[difficulty]))
      }
      answerList.append(correctAnswer)
      choiceArray = answerList.shuffled()
    case 3: // division
      secondNumber = Int.random(in: 2...9)
      correctAnswer = Int.random(in: 2...(difficultyArray[difficulty]/secondNumber)) // the result must be an integer
      firstNumber = correctAnswer * secondNumber
      var answerList = [Int]()

      for _ in 0...2 {
        answerList.append(Int.random(in: 1...difficultyArray[difficulty]))
      }
      answerList.append(correctAnswer)
      choiceArray = answerList.shuffled()
    default:
      break
    }
  }
}
