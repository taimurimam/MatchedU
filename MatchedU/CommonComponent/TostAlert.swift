//
//  TostAlert.swift
//  THE WiLL
//
//  Created by Taimur imam on 18/09/23.
//

import SwiftUI

struct TostAlert: View {
    
    var alertMessage = ""
    var body: some View {
        HStack{
            Spacer()
            Text(alertMessage)
                .padding(.top , 40)
            Spacer()
        }
        .font(.appFont(type: .medium, size: 15))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 120)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.3), radius: 10)
        .padding(.horizontal)
        .padding(.leading , 10)
    }
}


struct TostAlert_Previews: PreviewProvider {
    static var previews: some View {
        TostAlert()
    }
}
