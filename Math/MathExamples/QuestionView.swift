//
//  QuestionView.swift
//  Math
//
//  Created by user on 30.04.2023.
//

import SwiftUI


//struct Answer: View {
//
//  @State var answerText = ""
//  @State var isAnswerCorrect = false
//
//
//
//
//  var body: some View {
//    VStack {
//      HStack(spacing: 15) {
//        Text("\(firstNumber) \(operationType.sign) \(secondNumber)")
//          .font(.system(size: 25))
//          .bold()
//          .padding(.horizontal,20)
//          .background().cornerRadius(10)
//          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
//
//        Text("=")
//          .font(.system(size: 35))
//          .foregroundColor(.black)
//          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
//
//        TextField("answer", text: $answerText, onEditingChanged: { _ in
//            checkAnswer()
//        })
//          .multilineTextAlignment(.center)
//          .frame(width: 70)
//          .padding(.vertical, 5)
//          .font(.system(size: 15, weight: .bold))
//          .overlay(
//              RoundedRectangle(cornerRadius: 10)
//                  .stroke(.blue, lineWidth: 1))
//          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
//
//        Button(action: {
//            // Check if answer is correct
//            if answer == correctAnswer {
//                isAnswerCorrect = true
//            } else {
//                isAnswerCorrect = false
//            }
//        }, label: {
//            if isAnswerCorrect {
//                Image(systemName: "checkmark")
//                .foregroundColor(.green)
//
//            } else {
//                Image(systemName: "xmark")
//                .foregroundColor(.red)
//
//
//            }
//        })
//        .font(.system(size: 25, weight: .bold))
//        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
//
//      }
//    }
//
//  }
//}
//
//struct Answer_Previews: PreviewProvider {
//    static var previews: some View {
//      Answer(firstNumber: .constant(5), secondNumber: .constant(5),operationType: .constant(.addition), state: false)
//    }
//}

struct Numbers: View {

  @State var answerText = ""
    var difficulty: Int = 0
    var correctAnswer: Int = 0
  var selectedSign = OperationType.addition
    var firstNumber: Int {
      Int.random(in: 1...difficulty)
    }
    var secondNumber: Int {
      Int.random(in: 1...difficulty)
    }
  var body: some View {
    HStack {
      Text("\(firstNumber) \(selectedSign.sign) \(secondNumber)")
        .font(.system(size: 25))
        .bold()
        .padding(.horizontal,20)
        .background().cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

      Text("=")
        .font(.system(size: 35))
        .foregroundColor(.black)
        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

      TextField("answer", text: $answerText, onEditingChanged: { _ in

      })
      .multilineTextAlignment(.center)
      .frame(width: 70)
      .padding(.vertical, 5)
      .background(.white)
      .font(.system(size: 15, weight: .bold))
      .cornerRadius(10)
      .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
    }
  }


    mutating func generateAnswers() -> [Int] {
      var answerList = [Int]()
      switch selectedSign {
      case .addition:
        let first = firstNumber / 2
        let second = secondNumber / 2
        correctAnswer = first + second
        answerList.append(correctAnswer)

      case .subtraction:
        let first = Int.random(in: 1...difficulty/2)
        let second = Int.random(in: 1...first)
        correctAnswer = first - second
        answerList.append(correctAnswer)

      case .multiplication:
        let first = Int.random(in: 1...difficulty/2)
        let second = Int.random(in: 1...10)
        correctAnswer = first * second
        answerList.append(correctAnswer)

      case .division:
        let second = Int.random(in: 2...10)
        correctAnswer = Int.random(in: 1...difficulty/second)
        let first = correctAnswer * second
        answerList.append(correctAnswer)

      }
      return answerList
    }
  }



//struct Numbers_Previews: PreviewProvider {
//  static var previews: some View {
//    Numbers
//  }
//}



