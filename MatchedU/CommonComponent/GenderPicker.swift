//
//  GenderPicker.swift
//  MatchedU
//
//  Created by Taimur imam on 04/03/24.
//

import SwiftUI

enum Gender_: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}


struct GenderPicker: View {
    @Binding  var selectedGender : Gender_
    
    var body: some View {
        VStack{
            HStack{
                Text("Gender")
                    .foregroundColor(.placeholder)
                    .font(.appFont(type: .Regular, size: 16))
                    .padding(.leading)
                Spacer(minLength: 130)
                Picker("Select Gender", selection: $selectedGender) {
                    ForEach(Gender_.allCases, id: \.self) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .foregroundColor(.primary_color)
                .accentColor(.primary_color)
                .inputFieldStyle()
                .changeTextColor(.primary_color)
                .font(.appFont(type: .Regular, size: 16))
                .frame(height: 40)
                .background(Color.primary_color.opacity(0.15))
                .cornerRadius(8.0)
            }
            .padding(.trailing)
                Color.placeholder
                    .frame(maxWidth: .infinity , maxHeight: 1.0)
                    .padding(.horizontal)

        }
    }
}
