//
//  TextModifier.swift
//  Football
//
//  Created by Sk Azad on 21/07/23.
//

import SwiftUI

struct TextModifier: ViewModifier
{
    var fgColor: Color = .black
    var font: Font
    var textAlignment: TextAlignment = .leading
    
    func body(content: Content) -> some View
    {
        content.foregroundColor(fgColor).font(font).multilineTextAlignment(textAlignment)
    }
}

extension View {
    func textModifier(fgColor: Color = .black, font: Font, textAlignment: TextAlignment = .leading) -> some View {
        self.modifier(TextModifier(fgColor: fgColor, font: font, textAlignment: textAlignment))
    }
}
