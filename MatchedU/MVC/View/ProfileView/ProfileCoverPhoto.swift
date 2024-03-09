//
//  ProfileCoverPhoto.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.

import SwiftUI

struct ProfileCoverPhoto: View {
    let placeholder = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.FjLkalx51D8xJcpixUGJywHaE8%26pid%3DApi&f=1&ipt=359f941ea05d712d385f0cc2296f2fbc8a4317b264a61ef67af7c13d6dc24c40&ipo=images"
    var url = ""
    var height = 240.0
    var body: some View {
        if !url.isEmpty{ // if user has cover photo
            ZStack{
                Asyn_ImageView(url: url == mediaBaseUrl ? placeholder : url , width: 120 , height: Int(height) , cornerRedious: 0)
                    .frame( height: 240)
                    .frame(maxWidth: .infinity)
                    .clipped()
                LinearGradient(gradient: Gradient(colors: [.app_black.opacity(0.1), .app_white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
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
