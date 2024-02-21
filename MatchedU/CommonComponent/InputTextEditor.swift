//
//  InputTextEditor.swift
//  THE WiLL
//
//  Created by Taimur imam on 08/09/23.
//

import SwiftUI

struct InputTextEditor: View {
    var color_border : Color{
        return text.isEmpty ? Color.placeholder : Color.app_black
    }
    @Binding var text : String
    var hight = 75 
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
            }.inputDescriptionFieldStyle()
                if text.isEmpty{
                    VStack(alignment:.leading){
                        Text("let us know about your self.")
                            .foregroundColor(.placeholder)
                        Spacer()
                    }
                    .frame(height: CGFloat(hight))
                }
            TextEditor(text: $text)
                .inputDescriptionFieldStyle()
                .scrollContentBackground(.hidden)
            color_border
                .frame( height: 1)
                .padding(.horizontal)
        }
    }
}

struct InputTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        InputTextEditor(text: .constant(""))
    }
}

