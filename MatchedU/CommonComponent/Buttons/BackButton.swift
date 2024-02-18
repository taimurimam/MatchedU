//
//  BackButton.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button{
            dismiss()
        }label: {
            Image("back_btn")
        }
    }
}

//plus_btn


struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}


