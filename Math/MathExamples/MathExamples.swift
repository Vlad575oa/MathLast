//
//  SwiftUIView.swift
//  Math
//
//  Created by user on 30.04.2023.
//

import SwiftUI


struct Math: View {
  @State private var isAnimating = false
  @State private var difficulty = 0
  @State private var selectedSign = 0
  @State private var numbers = [(0, 0), (0, 0),(0, 0), (0, 0),(0, 0)]
  @State private var correctAnswers = [0, 0, 0, 0, 0]
  @State private var answerTexts = ["", "", "", "", ""]
  @State private var isAnswerCorrects = [false, false, false, false, false]
  @State private var isShowCorrect = false
  @State private var score = 0

  private let difficultyArray = [10, 20, 30, 50, 100]

  // OperationType place in Settings file
  private var operationType: OperationType {
    OperationType.allCases[selectedSign]
  }

  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .yellow, .green]),startPoint: .top, endPoint: .bottom ).ignoresSafeArea()

      VStack {
        Picker(selection: $selectedSign, label:
                Text("Level")) {
          ForEach(0..<OperationType.allCases.count, id: \.self) { index in
            Text("\(OperationType.allCases[index].rawValue)")
          }
        }
                .pickerStyle(.segmented)
                .onChange(of: selectedSign) { _ in
                  generateAnswers()
                }

        ForEach(numbers.indices) { index in
          HStack {
            Text("\(numbers[index].0) \(operationType.sign) \(numbers[index].1)")
              .font(.system(size: 25))
              .bold()
              .padding(.horizontal,20)
              .padding(.vertical, 5)
              .background().cornerRadius(10)
              .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

            Text("=")
              .font(.system(size: 35))
              .foregroundColor(.black)
              .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

            TextField("answer", text: $answerTexts[index], onEditingChanged: { _ in
              checkAnswer(index: index)
            })
            .multilineTextAlignment(.center)
            .frame(width: 70)
            .padding(.vertical, 5)
            .padding(.horizontal,5)
            .background(.white)
            .font(.system(size: 20, weight: .bold))
            .cornerRadius(7)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

            if isShowCorrect {
              if isAnswerCorrects[index] {
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
        }

        Button {
          generateAnswers()
          isShowCorrect = false
          answerTexts = ["", "", "", "", ""]
        } label: {
          Text("Generate")
        }
        .background()
        .cornerRadius(10)
        .padding(.horizontal, 10)
        .padding()
        .padding(.top,10)

        Button {
          checkAnswers()
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
        }
        .padding()

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
    }
  }

  private func checkAnswer(index: Int) {
    guard let input = Int(answerTexts[index]) else { return }
    isAnswerCorrects[index] = input == correctAnswers[index]
  }

  private func checkAnswers() {
    for i in 0..<numbers.count {
      guard let input = Int(answerTexts[i]) else { continue }
      isAnswerCorrects[i] = input == correctAnswers[i]
      if isAnswerCorrects[i] {
        score += 1
      } else {
        score -= 1
      }
    }
  }

  private func generateAnswers() {

    // Generate numbers and answers for each problem
    for i in 0..<numbers.count {
      switch operationType {
      case .addition:
        numbers[i].0 = Int.random(in: 1...(difficultyArray[difficulty]/2))
        numbers[i].1 = Int.random(in: 1...(difficultyArray[difficulty]/2))
        correctAnswers[i] = numbers[i].0 + numbers[i].1

      case .subtraction:
        numbers[i].0 = Int.random(in: 1...(difficultyArray[difficulty]/2))
        numbers[i].1 = Int.random(in: 1...numbers[i].0)
        correctAnswers[i] = numbers[i].0 - numbers[i].1

      case .multiplication:
        numbers[i].0 = Int.random(in: 2...(difficultyArray[difficulty]/2))
        numbers[i].1 = Int.random(in: 2...9)
        correctAnswers[i] = numbers[i].0 * numbers[i].1

      case .division:
        numbers[i].1 = Int.random(in: 2...9)
        correctAnswers[i] = Int.random(in: 1...(difficultyArray[difficulty]))
        numbers[i].0 = correctAnswers[i] * numbers[i].1
      }
    }
  }

}

struct Math_Previews: PreviewProvider {
  static var previews: some View {
    Math()
  }
}
