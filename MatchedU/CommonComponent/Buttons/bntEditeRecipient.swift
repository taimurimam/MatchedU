//
//  bntEditeRecipient.swift
//  THE WiLL
//
//  Created by Taimur imam on 18/11/23.
//

import SwiftUI

struct bntEditeRecipient: View {
    var body: some View {
        Image(systemName: "pencil")
            .frame(width: 34 , height: 34)
            .foregroundColor(.white)
            .font(.appFont(type: .medium, size: 20))
            .background(Color.app_blue)
            .cornerRadius(17)
            .padding(.horizontal)
            .padding(.top , 15)
            .padding(.bottom)

    }
}

struct bntDeleteRecipient: View {
    var body: some View {
        Image(systemName: "trash")
            .padding(.horizontal)
            .frame(width: 34 , height: 34)
            .foregroundColor(.white)
            .background(Color.red.opacity(0.75))
            .cornerRadius(17)
            .font(.appFont(type: .medium, size: 20))
    }
}


#Preview {
    bntEditeRecipient()
}
