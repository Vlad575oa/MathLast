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
