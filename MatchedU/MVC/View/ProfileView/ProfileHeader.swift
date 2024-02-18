//
//  ProfileHeader.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.
//

import SwiftUI

struct ProfileHeader: View {
    let img_url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.BOgoQKyG0N_RfsRhyzwp_QHaFj%26pid%3DApi&f=1&ipt=73c6a6a41a38b121c18d783c2b1332acd80f3bed23da816cd3335fcede218dd8&ipo=images"
    let utl = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.uXPJDoBupEgP_0cg3PZqwwHaD2%26pid%3DApi&f=1&ipt=2eefdc8fcab4b9538698aa641cf149d914f80d9a3a7da831a8fec233f453f38d&ipo=images"
    
    @Binding var userModel : UserModel
    
    var body: some View {
        ZStack(alignment:.bottom){
            ProfileCoverPhoto(url: utl)
            VStack{
                HeaderView(title: "Profile" , hideBackBtn: true, isEdItButton: true , titleColor : .app_white)
                    .padding(.top , 54)
                    .foregroundStyle(Color.app_white)
                Spacer()
            }
            .frame(height: 240)
            HStack(spacing: 15){
                ProfileImage(url: img_url , width: 56)
                VStack(alignment: .leading , spacing: 4){
                    Text(userModel.name)
                        .foregroundStyle(Color.app_black)
                        .font(.app_body_Font(type: .Bold, size: 18))
                    Text("\(userModel.collage) / \(userModel.graduation_year)")
                        .foregroundStyle(Color.text_secondary_color)
                        .font(.app_body_Font(type: .Bold, size: 15))
                }
                Spacer()
            }
            .frame(height: 72)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(36)
            .padding(.horizontal )
            .shadow(color: Color.black.opacity(0.08), radius: 17 , x: 4 , y: 8)
            .offset(y:36)
        }
    }
}

#Preview {
    ProfileView()
}
