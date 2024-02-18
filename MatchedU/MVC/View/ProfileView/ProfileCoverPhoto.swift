//
//  ProfileCoverPhoto.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.
//

import SwiftUI

struct ProfileCoverPhoto: View {
    var url = ""
    var height = 240.0
    var body: some View {
        if !url.isEmpty{ // if user has cover photo
            ZStack{
                Asyn_ImageView(url: url , width: 120 , height: Int(height) , cornerRedious: 0)
                    .frame( height: 240)
                    .frame(maxWidth: .infinity)
                    .clipped()
                LinearGradient(gradient: Gradient(colors: [.app_black.opacity(0.5), .app_white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .frame( height: height)
            }
        }else{ // if user does not have cover photo.....
            Color.primary_color
                .frame(height: height)
                .frame(maxWidth: .infinity)
        } 
    }
}

#Preview {
    ProfileCoverPhoto()
}
