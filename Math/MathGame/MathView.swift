//
//  ContentView.swift
//  MathGame
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI


struct MathView: View {
  @State private var isAnimating = false
  @State private var opacity = 0.0
  @State private var degress = 0.0
  @State private var answer = ""
  @State var correctAnswer = 1
  @State var choiceArray = [0, 1, 2, 3]
  @State private var operationType: OperationType = .addition
  @AppStorage("score") var score = 0

  @State var firstNumber = 0
  @State var secondNumber = 0
  @State var difficulty = 0
  @State var selectedSign = 0
  @State var hide = false

  var difficultyArray = [30, 50, 100, 500]


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

        Text("Сколько будет ")
          .multilineTextAlignment(.center)
          .font(.system(size: 35, weight: .semibold))


        Text("\(firstNumber) \(operationType.sign) \(secondNumber)")
          .font(.system(size: 45, weight: .bold))
          .bold()
          .padding()
          .background(LinearGradient(colors: [.purple, .blue], startPoint:.leading, endPoint: .trailing)).cornerRadius(40)
          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)

        HStack {

          ForEach(0..<2) {index in
            Button {
              answerIsCorrect(answer: choiceArray[index])
              generateAnswers()
              opacity = 0.0
              degress = 0

            } label: {
              AnswerButton(state: hide, number: choiceArray[index])
            }
          }
        }

        HStack {
          ForEach(2..<4) {index in
            Button {
              answerIsCorrect(answer: choiceArray[index])
              generateAnswers()
              opacity = 0.0
            } label: {
              AnswerButton(state: hide, number: choiceArray[index])
            }
          }
        }
        Spacer()
        VStack {
          Text("Счет: \(score)")
            .font(.system(size: 35, weight: .bold))
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)


          if hide {
            HStack {
                  TextField("Ответ", text: $answer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 150)
                    .background(.white)
                    .padding()
Spacer()
                  Button(action: {
                    let userAnswer = Int(answer) ?? 0
                    if userAnswer == correctAnswer {
                      generateAnswers()
                      score += 1
                      answer = ""
                    } else {
                      generateAnswers()
                      score -= 1
                      answer = ""
                    }
                  }) {
                    Text("Отправить")
                      .padding(.horizontal,30)
                      .padding(.vertical,4)
                      .font(.system(size: 20))
                      .foregroundColor(.black)
                      .background(.white)
                      .cornerRadius(3)
                      .padding(.trailing, 20)
                  }
              }
            }

          HStack {
            Button(action: {
              withAnimation(.easeOut(duration: 0.7)) {
                score = 0
                isAnimating = true
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimating = false
              }
            }) {
              Text("Сбросить счет")
                .font(.system(size: 18, weight: .medium))
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isAnimating ? Color.green : Color.blue)
                .cornerRadius(5)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
                .padding(.leading, 15)

          }
            Spacer()
            Button {
              withAnimation(.easeOut(duration: 1.0)) {
                hide.toggle()

              }
            }label: {
              Text(hide ? "Показать ответы" : "Скрыть ответы")
                .font(.system(size: 18, weight: .medium))
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.blue)
                .cornerRadius(5)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
                .padding(.trailing, 15)
            }
          }

          Spacer()

          Text("Уровень сложности")
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
        Spacer()
      }
    }
  }
}

struct MathView_Previews: PreviewProvider {
  static var previews: some View {
    MathView()
  }
}

//MARK: All logic (functions) in Settings file


