//
//  DeleteButton.swift
//  THE WiLL
//
//  Created by Taimur imam on 12/10/23.
//

import SwiftUI

struct DeleteButton: View {
    @Binding var isDelete : Bool
    var body: some View {
        Image(systemName: "trash")
            .padding()
            .foregroundColor(Color.text_red_color)
            .font(.appFont(type: .medium, size: 20))
            .padding()
            .frame(width: 36 , height: 38)
            .background(Color.white)
            .cornerRadius(18.0)
            .shadow(color: Color.black.opacity(0.1), radius: 5)
            .padding(.trailing , 25)
            .padding(.top , 10)
            .onTapGesture {
                isDelete.toggle()
            }
    }
}

#Preview {
    DeleteButton(isDelete: .constant(false))
}
