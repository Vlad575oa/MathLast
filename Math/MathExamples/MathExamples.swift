//
//  SwiftUIView.swift
//  Math
//
//  Created by user on 30.04.2023.
//

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
  private var isAllFieldsFilled: Bool {
    answerTexts.allSatisfy { !$0.isEmpty }
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
Spacer()
          ScrollView {
            ForEach(numbers.indices, id: \.self) { index in
              HStack(spacing: 10) {
                Text("\(numbers[index].0) \(operationType.sign) \(numbers[index].1)")
                  .font(.system(size: 20))
                  .bold()
                  .padding(.horizontal,20)
                  .padding(.vertical, 5)
                  .foregroundColor(.black)
                  .background(.white).cornerRadius(10)
                  .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

                Text("=")
                  .font(.system(size: 30))
                  .foregroundColor(.black)
                  .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

                TextField("answer", text: $answerTexts[index], onEditingChanged: { _ in
                  checkAnswer(index: index)
                })
                .multilineTextAlignment(.center)
                .frame(width: 90)
                .padding(.vertical, 5)
                .padding(.horizontal,5)
                .background(.white)
                .foregroundColor(.blue)
                .font(.system(size: 20, weight: .bold))
                .cornerRadius(7)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
                .keyboardType(.numberPad)
                .onChange(of: answerTexts[index]) { _ in
                  if isAllFieldsFilled {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                  }
                }

                if isShow {
                  if isAnswerCorrects[index] {
                    Image(systemName: "checkmark")
                      .foregroundColor(.green)
                      .font(.system(size: 20, weight: .medium))

                  } else if isShow && !isAnswerCorrects[index] && answerTexts[index] != "" {

                    Image(systemName: "xmark")
                      .foregroundColor(.red)
                      .font(.system(size: 15, weight: .medium))
                    Text("\(correctAnswers[index])")
                      .font(.system(size: 20))
                      .foregroundColor(.red)
                      .padding(.horizontal, 10)
                  }
                }
              }
            }


            Button {
              checkAnswers()
            } label: {
              Text("Check Answers")
                .font(.system(size: 20))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 7)
            .background(.white)
            .cornerRadius(10)
            .foregroundColor(.blue)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
            .padding(.top, 10)

            Button {
              generateAnswers()
              isShow = false
              scoreCount = false
              answerTexts = ["", "", "", "", ""]
            } label: {
              Text("Next")
                .font(.system(size: 20))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 7)
            .background(.white)
            .cornerRadius(10)
            .foregroundColor(.black)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
            .padding(.top, 10)
          }
          Spacer()

          HStack(spacing: 30) {
            Text("\(NSLocalizedString("Answer", comment: "")) + : \(scoreRight)")
              .font(.system(size: 20))
              .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
            Text("\(NSLocalizedString("Answer", comment: "")) - : \(scoreWrong)")
              .font(.system(size: 20))
              .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
          } .padding(.top, 10)

          Button("Reset") {
            scoreRight = 0
            scoreWrong = 0
          }
          .padding(.horizontal, 20)
          .padding(.vertical, 5)
            .font(.system(size: 20))
            .background(.white)
            .cornerRadius(10)

          Text("Level")
            .font(.system(size: 20))

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


        .toolbar {
          ToolbarItem(placement: .keyboard) {
            HStack {
              Button("Hide Keyboard") {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
              }
            }
          }
        }
        .onAppear {
          generateAnswers()
        }

    }
    .ignoresSafeArea(.keyboard)
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
