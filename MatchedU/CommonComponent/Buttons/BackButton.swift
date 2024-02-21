//
//  BackButton.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.
//

import SwiftUI

struct BackButton: View {
    var isDownBackBtn = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button{
            dismiss()
        }label: {
            if isDownBackBtn{
                Image(systemName: "chevron.down")
                    .foregroundColor(.app_black)
                    .font(.app_body_Font(type: .Regular, size: 22))
                    .btnActionStyle()
            }else{
                Image("arrow-left")
                    .btnActionStyle()
            }
        }
    }
}

//plus_btn


struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}


