//
//  ProfileImage.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.
//

import SwiftUI

struct ProfileImage: View {
    var url = ""
    var width = 0.0
    var leading_padding = 12.0
    var body: some View {
        VStack{
            if !url.isEmpty{
                Asyn_profile_ImageView(url: url , width: Int(width) , height: Int(width) , cornerRedious: Int(width)/2)
                    .padding(.leading , leading_padding)
            }else{
                Image(systemName: "person.circle")
                    .font(.appFont(type: .Bold, size: 36))
                    .foregroundStyle(Color.app_white)
                    .frame(width: width , height: width)
                    .background(Color.primary_color)
                    .cornerRadius(width/2)
                    .padding(.leading , leading_padding)
            }
        }
    }
}

#Preview {
    ProfileImage()
}
