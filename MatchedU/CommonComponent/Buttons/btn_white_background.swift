//
//  btn_white_background.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.
//

import SwiftUI

struct Btn_white_background: View {
    var title = ""
    var color = Color.app_blue
    var body: some View {
        ZStack{
            Text(title)
                .padding(.horizontal , 40)
                .foregroundColor(color)
        
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
       // .background(Color.red)
        .cornerRadius(12)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color, lineWidth: 1.0)
            )
        .padding(.horizontal)
    }
}

struct btn_white_background_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
