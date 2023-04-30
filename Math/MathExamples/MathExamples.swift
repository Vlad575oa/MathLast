//
//  SwiftUIView.swift
//  Math
//
//  Created by user on 30.04.2023.
//

import SwiftUI

struct Math: View {
  @State private var isAnimating = false
  @State private var answer = ""
  @State private var answer1 = ""
  @State var correctAnswer = 0
  @State var correctAnswer1 = 0
  @State var choiceArray = [0, 1, 2, 3]
  @State private var operationType: OperationType = .addition
  @AppStorage("score") var score = 0

  @State var answerText = ""
  @State var answerText1 = ""
  @State var isAnswerCorrect = false
  @State var isAnswerCorrect1 = false
  @State var isShowCorrect = false
  @State var firstNumber = 0
  @State var secondNumber = 0

  @State var thirdNumber = 0
  @State var forthNumber = 0

  @State var difficulty = 0
  @State var selectedSign = 0
  @State var hide = false

  var difficultyArray = [10, 20, 30, 50, 100]


  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.green, .yellow, .blue]),startPoint: .top, endPoint: .bottom ).ignoresSafeArea()

      VStack {
        Picker(selection: $selectedSign, label:
                Text("Level")) {
          ForEach(0..<OperationType.allCases.count, id: \.self) { index in
            Text("\(OperationType.allCases[index].rawValue)")

          }
        }.pickerStyle(.segmented)
          .onChange(of: selectedSign) { newValue in
            self.selectedSign = newValue
            self.operationType = OperationType.allCases[newValue]
            generateAnswers()
          }

        // пример 1
        HStack {
          Text("\(firstNumber) \(operationType.sign) \(secondNumber)")
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
            checkAnswer()
          })
          .multilineTextAlignment(.center)
          .frame(width: 70)
          .padding(.vertical, 5)
          .background(.white)
          .font(.system(size: 15, weight: .bold))
          .cornerRadius(10)
          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

          if isShowCorrect {
            if isAnswerCorrect {
              Image(systemName: "checkmark")
                .foregroundColor(.green)
                .font(.system(size: 25, weight: .heavy))

            } else {
              Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(.system(size: 25, weight: .heavy))
            }
          }
        }

        //пример 2
        HStack {
          Text("\(thirdNumber) \(operationType.sign) \(forthNumber)")
            .font(.system(size: 25))
            .bold()
            .padding(.horizontal,20)
            .background().cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

          Text("=")
            .font(.system(size: 35))
            .foregroundColor(.black)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

          TextField("answer", text: $answerText1, onEditingChanged: { _ in
            checkAnswer1()
          })
          .keyboardType(.numberPad)
          .multilineTextAlignment(.center)
          .frame(width: 70)
          .padding(.vertical, 5)
          .background(.white)
          .font(.system(size: 15, weight: .bold))
          .cornerRadius(10)
          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

          if isShowCorrect && answerText1 != "" {
            if Int(answerText1) == correctAnswer1 {
              Image(systemName: "checkmark")
                .foregroundColor(.green)
                .font(.system(size: 25, weight: .heavy))

            } else if Int(answerText1) != correctAnswer1 {
              Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(.system(size: 25, weight: .heavy))
            }
          }
        }

        Button {
          generateAnswers()
          generateAnswers1()
          isShowCorrect = false
          answerText = ""
          answerText1 = ""

        } label: {
          Text("Generate")
        }
        .background()
        .cornerRadius(10)
        .padding(.horizontal,10)
        .padding()
        .padding(.top,10)


        Button {
          checkAnswer()
          checkAnswer1()
          isShowCorrect.toggle()


        } label: {
          Text("Check Answer")
        }
        .background()
        .cornerRadius(10)
        .padding(.horizontal,10)
        .padding()
        .padding(.top,10)

        Spacer()
        HStack {
          Text("Answer +: \(score)")
            .font(.system(size: 15, weight: .bold))
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
          Text("Answer -: \(score)")
            .font(.system(size: 15, weight: .bold))
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
        }.padding()


        Text("Level")
        withAnimation(.easeInOut(duration: 0.5)) {
          Picker(selection: $difficulty, label:
                  Text("Level")) {
            ForEach(0..<difficultyArray.count, id: \.self) {
              Text("\(difficultyArray[$0])")
            }
          }
                  .pickerStyle(SegmentedPickerStyle())
        }
      }

    }
    .onAppear {
      generateAnswers()
      generateAnswers1()
    }
  }


  func checkAnswer() {
    guard let input = Int(answerText) else { return }
    if input == correctAnswer && answerText1 != "" {
      isAnswerCorrect = true
    } else {
      isAnswerCorrect = false
    }
  }


  func checkAnswer1() {
    guard let input = Int(answerText1) else { return }
    if input == correctAnswer1 && answerText1 != "" {
      isAnswerCorrect1 = true
      self.score += 1
    } else {
      isAnswerCorrect1 = false
      self.score -= 1
    }
  }
}

struct Math_Previews: PreviewProvider {
  static var previews: some View {
    Math()
  }
}
