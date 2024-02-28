
//  ProfileView.swift
//  MatchedU
//  Created by Taimur imam on 16/02/24.

import SwiftUI
import SwiftyJSON


struct ProfileView: View {
   @State private var userModel : UserModel = UserModel(from: JSON())
   @State var user_id = ""
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 25){
                ZStack(alignment: .topTrailing){
                    ProfileHeader(userModel: userModel)
                    if userModel.id == loggedinUser.id || user_id.isEmpty{
                        NavigationLink(destination: EditProfie( userModel: $userModel )) {
                        Image("edit")
                            .frame(width: 30 , height: 30)
                            .clipShape(Circle())
                            .padding(.trailing)
                            .padding(.bottom)
                            .padding(.top , 44)
                    }
                }
                }
                ScrollView{
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
                        if userModel.isMyProfile{
                            PersonalInfoCell(icon: "profile_email" , title: "Email" , value: userModel.email)
                        }
                        PersonalInfoCell(icon: "profile_collage" , title: "College/School" , value: userModel.collage)
                        PersonalInfoCell(icon: "profile_graguation_year" , title: "Graduation Year" , value: userModel.graduation_year)
                        PersonalInfoCell(icon: "profile_dob" , title: "Year of birth" , value: userModel.birthYear)
                        if userModel.isMyProfile{
                            ZStack(alignment:.trailing){
                                PersonalInfoCell(icon: "linkedin" , title: "Linked In" , value: userModel.linkdin_url)
                                Text("visit")
                                    .padding(.horizontal)
                                    .frame(height: 30)
                                    .background(Color.primary_color)
                                    .clipShape(Capsule())
                                    .foregroundStyle(Color.app_white)
                                    .onTapGesture { 
                                        // go to the linked In link.
                                        //                                    let url  = URL(string: userModel.linkdin_url)
                                        //                                    if UIApplication.shared.canOpenURL(url!) {
                                        //                                        UIApplication.shared.open(URL(string: userModel.linkdin_url)!, options: [:])
                                        //                                    }
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.top , 30) // End personal information section
                    ProfileStoryView(userModel: $userModel)
                }
                .padding(.top , 40)
                Spacer()
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .task {
                if user_id.isEmpty{
                    user_id = loggedinUser.id
                }
                getUserProfile()
            } 
        }
    }
    
    
    //MARK: - GetUserProfile
    
    func getUserProfile(){
        UserApiCall().userProfileOf(user_id: user_id.isEmpty ?  loggedinUser.id : user_id) { _response, isSuccess in
           if isSuccess{
               
               userModel = UserModel(from: _response.completeJsonResp["data"]["user_data"])
               if userModel.isMyProfile{
                   UserDefaults.saveJSON(_response.completeJsonResp["data"]["user_data"] , .userDetails)
               }
            }else{
                
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
