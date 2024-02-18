//
//  PlusButton.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.
//

import SwiftUI

struct PlusButton: View {

    var body: some View {
        Image(systemName: "plus")
            .foregroundStyle(Color.white)
            .font(.appFont(type: .Bold, size: 34))
            .frame(width: 60 , height: 60)
            .background(Color.primary_color)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.2), radius: 30 , x: 4 , y: 10)
    }
}
