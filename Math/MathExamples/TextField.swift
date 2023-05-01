//
//  TextField.swift
//  Math
//
//  Created by user on 01.05.2023.
//

import SwiftUI

struct FocusableTextField: UIViewRepresentable {
    @Binding var text: String
    var tag: Int
    var placeholder: String
    var keyboardType: UIKeyboardType

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.tag = tag
        textField.keyboardType = keyboardType
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange), for: .editingChanged)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FocusableTextField

        init(_ parent: FocusableTextField) {
            self.parent = parent
        }

        @objc func textFieldDidChange(textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}
