//
//  ProfileImage.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.
//

import SwiftUI

struct ProfileImage: View {
    let link = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.Q-ZRtH2jCAePPB7VN76XqQHaHa%26pid%3DApi&f=1&ipt=0da107b1a30a35654e2ee85c98a4415b5e0651ea459e67d31294eec788da3c9a&ipo=images" 
    var url = ""
    var width = 0.0
    var leading_padding = 12.0
    var body: some View {
        VStack{
            if !url.isEmpty{
                Asyn_profile_ImageView(url:  url == mediaBaseUrl ? link : url , width: Int(width) , height: Int(width) , cornerRedious: Int(width)/2)
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
