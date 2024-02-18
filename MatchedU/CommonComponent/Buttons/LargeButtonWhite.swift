//
//  LargeButtonWhite.swift
//  THE WiLL
//
//  Created by Taimur imam on 07/09/23.
//

import SwiftUI




struct LargeButtonWhite: View {
    var title = "LOGIN"
    var body: some View {
        ZStack{
            Image("white_btn")
            Text(title)
                .foregroundColor(.white)
                .offset(y: -14)
        }
    }
}


struct LargeButtonWhite_Previews: PreviewProvider {
    static var previews: some View {
        LargeButtonWhite()
    }
}

struct Cross_blue_btn : View{
    var icon = "back"
    @Environment(\.dismiss) var dismiss
    var body: some View{
        Button{
            dismiss()
        }label: {
            Image("Close x icon_blue")
                .foregroundColor(.white)
        }
    }
}
