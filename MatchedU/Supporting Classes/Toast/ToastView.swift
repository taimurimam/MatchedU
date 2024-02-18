//
//  ToastView.swift
//  Aikina
//
//  Created by Sk Azad on 10/06/23.
//

import SwiftUI

enum ToastPosition {
    case top
    case bottom
    case center
}

struct ToastView: View {
    @Binding var message: String
    
    @Binding var isShowing: Bool
    var postion: ToastPosition = .center
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    if postion == .bottom
                    {
                        Spacer()
                    }
                    
                    if isShowing {
                        VStack {
                            Text(message)
                                .padding()
                                .background(Color.app_blue)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                                .textModifier(font: .appFont(type: .Regular, size: 20))
                        }
                        .padding()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                hideToast()
                            }
                        }
                    }
                    
                    if postion == .top
                    {
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: (geometry.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom))
            }
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.black.opacity(0.4))
            .onTapGesture {
                hideToast()
            }
        }
    }
    
    private func hideToast() {
        withAnimation {
            isShowing = false
        }
    }
}
