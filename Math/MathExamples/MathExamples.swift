//
//  SwiftUIView.swift
//  Math
//
//  Created by user on 30.04.2023.
//

import SwiftUI


struct Math: View {

  @State private var difficulty = 0
  @State private var selectedSign = 0
  @State private var numbers = [(0, 0), (0, 0),(0, 0), (0, 0),(0, 0)]
  @State private var correctAnswers = [0, 0, 0, 0, 0]
  @State private var answerTexts = ["", "", "", "", ""]
  @State private var isAnswerCorrects = [false, false, false, false, false]
  @State private var isShow = false
  @State private var scoreCount = false
  @State private var scoreRight = 0
  @State private var scoreWrong = 0

  private var difficultyArray = [20, 50, 100, 500, 1000]
  private var difficultyLevel = ["1", "2", "3", "4", "5"]

  // OperationType place in Settings file
  private var operationType: OperationType {
    OperationType.allCases[selectedSign]
  }

  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.purple, .yellow, .green]),startPoint: .top, endPoint: .bottom ).ignoresSafeArea()

      VStack {
        Picker(selection: $selectedSign, label:
                Text("Level")) {
          ForEach(0..<OperationType.allCases.count, id: \.self) { index in
            Text(OperationType.allCases[index].rawValue)
          }
        }
                .pickerStyle(.segmented)
                .onChange(of: selectedSign) { _ in
                  generateAnswers()
                }

        ForEach(numbers.indices, id: \.self) { index in
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


            if isShow {
              if isAnswerCorrects[index] {
                Image(systemName: "checkmark")
                  .foregroundColor(.green)
                  .font(.system(size: 25, weight: .heavy))
                
              } else if isShow && !isAnswerCorrects[index] && answerTexts[index] != "" {
                
                Image(systemName: "xmark")
                  .foregroundColor(.red)
                  .font(.system(size: 25, weight: .heavy))
                Text("\(correctAnswers[index])")
                  .font(.system(size: 25))
                  .foregroundColor(.red)
                  .padding(.horizontal, 10)
              }
            }
          }
        }

        Button {
          checkAnswers()
        } label: {
          Text("Check Answer")
        }
        .padding()
        .background()
        .cornerRadius(10)
        .foregroundColor(.blue)
        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

        Button {
          generateAnswers()
          isShow = false
          scoreCount = false
          answerTexts = ["", "", "", "", ""]
        } label: {
          Text("Next")
        }
        .padding()
        .background()
        .cornerRadius(10)
        .padding()
        .foregroundColor(.black)
        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
        Spacer()

        HStack(spacing: 30) {
          Text("Answer + : \(scoreRight)")
            .font(.system(size: 25))
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
          Text("Answer - : \(scoreWrong)")
            .font(.system(size: 25))
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
        }.padding()

        Button("Reset") {
          scoreRight = 0
          scoreWrong = 0
        }.padding()
          .background(.white)
          .cornerRadius(10)
        Spacer()

        Text("Level")
        withAnimation(.easeInOut(duration: 0.5)) {
          Picker(selection: $difficulty, label:
                  Text("Level")) {
            ForEach(0..<difficultyLevel.count, id: \.self) {
              Text("\(difficultyLevel[$0])")
            }
          }
                  .pickerStyle(SegmentedPickerStyle())
                  .onChange(of: difficulty) { _ in
                        generateAnswers()
                      }
        }
      }
    }
    .onAppear {
      generateAnswers()
    }
  }

  private func checkAnswer(index: Int) {
      guard let input = Int(answerTexts[index]) else {
          isAnswerCorrects[index] = false
          return
      }
      isAnswerCorrects[index] = input == correctAnswers[index]
  }

  private func checkAnswers() {
    guard !answerTexts.contains("") else {
      let alert = UIAlertController(title: "Empty answer",
                                    message: "Please fill all answer",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let window = windowScene.windows.first {
        window.rootViewController?.present(alert, animated: true, completion: nil)
      }
      return
    }
    var newScoreRight = 0
    var newScoreWrong = 0

    if isShow == false {
      for i in 0..<numbers.count {
        isAnswerCorrects[i] = Int(answerTexts[i]) == correctAnswers[i]
        if isAnswerCorrects[i] {
          newScoreRight += 1
        } else {
          newScoreWrong -= 1
        }
      }
      scoreRight += newScoreRight
      scoreWrong += newScoreWrong
      isShow = true
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
