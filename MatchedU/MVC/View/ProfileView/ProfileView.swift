
//  ProfileView.swift
//  MatchedU
//  Created by Taimur imam on 16/02/24.

import SwiftUI

struct ProfileView: View {
    @State private var userModel : UserModel = loggedinUser
    @State private var stories = [StoryModel]()
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 25){
                ProfileHeader(userModel: $userModel)
                ScrollView{
                    ProfileStoryView(arrStory: userModel.stories)
                    VStack(alignment: .leading ,spacing: 12){ // About Me
                        HStack{
                            Text("About Me")
                                .profileSectionTitleStyle()
                            Spacer()
                        }
                        Text(userModel.bio)
                            .font(.app_body_Font(type: .Bold, size: 18))
                            .foregroundStyle(Color.text_secondary_color)
                            .lineSpacing(7)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    VStack(alignment: .leading,spacing: 25){ // Personal information section
                        Text("Personal Information")
                            .profileSectionTitleStyle()
                        PersonalInfoCell(icon: "profile_email" , title: "Email" , value: userModel.email)
                        PersonalInfoCell(icon: "profile_collage" , title: "College/School" , value: userModel.collage)
                        PersonalInfoCell(icon: "profile_graguation_year" , title: "Graduation Year" , value: userModel.graduation_year)
                        PersonalInfoCell(icon: "profile_dob" , title: "Date of birth" , value: userModel.dob)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.top , 30) // End personal information section
    
                }
                .padding(.top , 40)
                Spacer()
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .task {
                getUserProfile()
            }
        }
    }
    
    
    //MARK: - GetUserProfile
    
    func getUserProfile(){
        UserApiCall().userProfileOf(user_id: loggedinUser.id) { _response, isSuccess in
           if isSuccess{
               userModel = UserModel(from: _response.completeJsonResp["data"]["user_data"])
               UserDefaults.saveJSON(_response.completeJsonResp["data"]["user_data"] , .userDetails)
            }else{
                print("")
            }
        }
    }
}

#Preview {
    ProfileView()
}


struct PersonalInfoCell: View {
    var icon = ""
    var title = ""
    var value = ""
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .frame(width: 58 , height: 58)
            VStack(alignment:.leading , spacing: 8){
                Text(title)
                    .font(.app_body_Font(type: .Regular, size: 16))
                    .foregroundStyle(Color.text_secondary_color)
                Text(value)
                    .font(.app_body_Font(type: .Regular, size: 17))
                    .foregroundStyle(Color.app_black)
            }
            .padding(.leading , 10)
            Spacer()
        }
    }
}
