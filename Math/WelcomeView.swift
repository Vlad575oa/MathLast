//
//  WelcomeView.swift
//  SimpleGame
//
//  Created by user on 31.03.2023.
//

import SwiftUI

struct WelcomeView: View {

  var body: some View {
    NavigationView {
      ZStack {
        LinearGradient(gradient: Gradient(colors: [Color.green, Color.indigo, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
          .edgesIgnoringSafeArea(.all)
        VStack {
          Text("Welcome")
            .multilineTextAlignment(.center)
            .font(.system(size: 30, weight: .heavy, design: .default))
            .shimmer(.init(tint: .white.opacity(0.5), highlight: .white, blur: 5))
            .padding(.all, 50)


          VStack(spacing: 35) {
            NavigationLink(destination: Math()) {
              Text("Math examples")
                .modifier(TextModifier(color: .green))
            }


            NavigationLink(destination: MathView()) {
              Text("Math Game")
                .modifier(TextModifier(color: .purple))
            }
          }
          Spacer()
        }
        .navigationBarTitle("Menu", displayMode: .inline)
        .foregroundColor(.white)
        //        .navigationBarItems(leading:
        //        Button(action: {
        //        }) {
        //        },trailing:
        //                              NavigationLink(destination: SettingsView()) {
        //          Image(systemName: "gear")
        //          .foregroundColor(.white)
        //        }
        //        )
      }
    }

  }

}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}



