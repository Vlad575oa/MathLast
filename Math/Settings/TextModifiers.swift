//
//  TextModifiers.swift
//  SimpleGames
//
//  Created by user on 31.03.2023.
//

import SwiftUI

struct TextModifier: ViewModifier {
let color: Color
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: Color.gray, radius: 5, x: 4, y: 5)
    }
}

struct TextModifier2: ViewModifier {
let color: Color
let scale: CGFloat
    func body(content: Content) -> some View {
        content
        .font(.system(size: 23))
        .padding(.horizontal, 35)
        .padding(.vertical, 18)
        .background(color.opacity(0.8))
        .foregroundColor(.white)
        .cornerRadius(15)
        .shadow(color: Color.gray, radius: 4, x: 5, y: 5)
        .scaleEffect(scale)
    }
}

struct TextModifier3: ViewModifier {
let color: Color
let scale: CGFloat
    func body(content: Content) -> some View {
        content
        .font(.system(size: 20))
        .padding(.horizontal, 50)
        .padding(.vertical, 17)
        .background(color.opacity(0.8))
        .foregroundColor(.white)
        .cornerRadius(15)
        .padding()
        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 5, y: 5)
        .scaleEffect(scale)
    }
}


