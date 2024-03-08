//
//  ProfileHeader.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.
//

import SwiftUI

struct ProfileHeader: View {
    
    var userModel : UserModel
    @Binding var isBackButton : Bool 
    var isUserList = false
    @Binding  var show_confirmationAlert : Bool
    var sendConectionRequest:()-> Void
    var body: some View {
        ZStack(alignment:.bottom){
            ProfileCoverPhoto(url: userModel.cover_image )
            if !isUserList{ 
                VStack{
                    HeaderView(title: "" , hideBackBtn: !isBackButton, isEdItButton: true , titleColor : .app_white)
                        .padding(.top , 54)
                        .foregroundStyle(Color.app_white)
                    Spacer()
                }
                .frame(height: 240)
            }
            HStack(spacing: 15){
                ProfileImage(url: userModel.profile_image , width: 56 , leading_padding : 10)
                VStack(alignment: .leading , spacing: 4){
                    Text(userModel.name)
                        .foregroundStyle(Color.app_black)
                        .font(.app_body_Font(type: .Bold, size: 18))
                    Text("\(userModel.collage) / \(userModel.graduation_year)")
                        .foregroundStyle(Color.text_secondary_color)
                        .font(.app_body_Font(type: .Bold, size: 15))
                }
                Spacer()
                if userModel.isMyProfile{ // logout Button
                    Button{
                        show_confirmationAlert.toggle()
                    }label: {
                        Image("logout")
                            .padding(.trailing)
                    } 
                }else{ // addd follow button for other user..
                    if userModel.conectionStatus == .notConected{
                        Button{
                            sendConectionRequest()
                        }label: {
                            Image("followButton")
                                .padding(.trailing)
                        }
                    }
                }
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
