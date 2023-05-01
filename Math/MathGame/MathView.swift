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
  @State var selectedSign = 0
  @State var hide = false
  
  @State var difficulty = 0
  var difficultyArray = [30, 50, 100, 500, 1000]
  var difficultyLevel = ["1", "2", "3", "4", "5"]
  
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.green, .yellow, .blue]),startPoint: .top, endPoint: .bottom ).ignoresSafeArea()
      
      VStack(spacing: 30) {
        Picker(selection: $selectedSign, label:
                Text("Level")) {
          ForEach(0..<OperationType.allCases.count, id: \.self) { index in
            Text("\(OperationType.allCases[index].rawValue)")
            
          }
        }.pickerStyle(.segmented)
          .padding(.top, 20)
          .onChange(of: selectedSign) { newValue in
            self.selectedSign = newValue
            self.operationType = OperationType.allCases[newValue]
            generateAnswers()
          }
        
        Text("How much?")
          .multilineTextAlignment(.center)
          .font(.system(size: 35, weight: .semibold))
        
        
        Text("\(firstNumber) \(operationType.sign) \(secondNumber)")
          .font(.system(size: 45, weight: .bold))
          .bold()
          .padding()
          .background(LinearGradient(colors: [.purple, .blue], startPoint:.leading, endPoint: .trailing)).cornerRadius(40)
          .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
        
        HStack(spacing: 20) {
          
          ForEach(0..<2) {index in
            Button {
              answerIsCorrect(answer: choiceArray[index])
              generateAnswers()
              opacity = 0.0
              degress = 0
              
            } label: {
              AnswerButton(number: choiceArray[index])
            }
          }
        }
        
        HStack(spacing: 20){
          ForEach(2..<4) {index in
            Button {
              answerIsCorrect(answer: choiceArray[index])
              generateAnswers()
              opacity = 0.0
            } label: {
              AnswerButton(number: choiceArray[index])
            }
          }
        }
        Spacer()
        VStack {
          Text("Score: \(score)")
            .font(.system(size: 30, weight: .bold))
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
          
          Button(action: {
            withAnimation(.easeOut(duration: 0.7)) {
              score = 0
              isAnimating = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              isAnimating = false
            }
          }) {
            Text("Reset")
              .font(.system(size: 30, weight: .medium))
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
        }
        Spacer()
        
        Text("Level")
          .font(.system(size: 20, weight: .medium))
          .padding()
        
        withAnimation(.easeInOut(duration: 0.5)) {
          Picker(selection: $difficulty, label:
                  Text("Level")) {
            ForEach(0..<difficultyLevel.count, id: \.self) {
              Text("\(difficultyArray[$0])")
            }
          }
                  .pickerStyle(SegmentedPickerStyle())
                  .onChange(of: difficulty) { _ in
                    generateAnswers()
                  }
        }
      }
      Spacer()
    }
    .onAppear {
      generateAnswers()
    }
  }
  
}



struct MathView_Previews: PreviewProvider {
  static var previews: some View {
    MathView()
  }
}

//MARK: All logic (functions) in Settings file


