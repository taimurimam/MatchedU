//
//  ToastModifier.swift
//  Aikina
//
//  Created by Sk Azad on 10/06/23.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    @Binding var message: String
    var position = ToastPosition.center

    func body(content: Content) -> some View {
        content
            .overlay(
                ToastView(message: $message, isShowing: $isShowing, postion: position)
                    .opacity(isShowing ? 1 : 0)
            )
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: Binding<String>, postion: ToastPosition = .center) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message, position: postion))
    }
}
