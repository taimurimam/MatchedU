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
                .frame(height: 82)
                .foregroundColor(.white)
                .font(.appFont(type: .Regular, size: 17))
        }
        .loginButtonStyle()
    }
}

struct Large_Blue_Button_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
