//
//  Large_Blue_Button.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.
//

import SwiftUI

struct Large_Blue_Button: View {
    var title = "LOGIN"
    var body: some View {

        ZStack{
            Text(title)
                .frame(maxWidth: .infinity) 
                .foregroundColor(.white)
                .font(.appFont(type: .Regular, size: 17))
        }
        .loginButtonStyle()
    }
}


struct Post_Button: View {
    var title = "Post"
    var body: some View {
        ZStack{
            Text(title)
                .frame(height: 42)
                .foregroundColor(.white)
                .font(.appFont(type: .Regular, size: 17))
        }
        .padding()
        .frame(height: 42)
        .background(Color.app_blue)
        .cornerRadius(8)
        .shadow(color: .button_shado, radius: 10 , x: 0.0 , y: 10.0)    }
}



struct Large_Blue_Button_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
