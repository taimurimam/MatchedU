//
//  PasswordResetedMessage.swift
//  THE WiLL
//
//  Created by Taimur imam on 16/10/23.
//

import SwiftUI

struct PasswordResetedMessage: View {
    @Binding var isHideCongratulationpopup : Bool
    var body: some View {
        ZStack{
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            VStack(spacing: 20){
                
               Text("Congratulations")
                    .foregroundColor(.red)
                    .font(.appFont(type: .Bold, size: 30))
                    .padding()
                Text("You have updated your password successfully. ")
                    .padding()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .font(.appFont(type: .medium, size: 18))
                NavigationLink(destination: Text("")){
                    Text("Login")
                        .white_btn_style()
                        .font(.appFont(type: .Regular, size: 17))
                        .padding(.horizontal)
                }
                Button{
                    withAnimation{ 
                        isHideCongratulationpopup.toggle()
                    }
                }label: {
                    Text("Ok")
                        .white_btn_style()
                        .font(.appFont(type: .Regular, size: 17))
                    }
                }
            .frame(width: 320, height: 380)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    PasswordResetedMessage( isHideCongratulationpopup: .constant(false))
}
