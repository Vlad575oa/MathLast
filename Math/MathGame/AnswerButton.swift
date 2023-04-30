//
//  AnswerButton.swift
//  MathGame
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI

struct AnswerButton: View {
    var state: Bool
    var number : Int
    
    var body: some View {
        
            Text("\(number)")
            .frame(width: 90, height: 70)
            .font(.system(size: 45, weight: .bold)).opacity(state ? 0.02 : 1)
                .padding(7)
                .background(LinearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottom)).cornerRadius(30)
                .foregroundColor(.black)

                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
              
              
        
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
      AnswerButton(state: false, number: 100)
    }
}
