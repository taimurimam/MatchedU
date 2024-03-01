
//  ProfileView.swift
//  MatchedU
//  Created by Taimur imam on 16/02/24.

import SwiftUI
import SwiftyJSON
import AlertToast

struct ProfileView: View {
   @State private var userModel : UserModel = UserModel(from: JSON())
   @State var user_id = ""
   @State  var show_confirmationAlert = false
   @State var isLoggedOut = false
   @State var toastMessage = ""
   @State var isToastMessage = false
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 25){
                ZStack(alignment: .topTrailing){
                    NavigationLink(destination: LoginView() , isActive:$isLoggedOut ){}
                    ProfileHeader(userModel: userModel , show_confirmationAlert: $show_confirmationAlert)
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
                                btnVisit(link: userModel.linkdin_url)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.top , 30) // End personal information section
                    ProfileStoryView(userModel: $userModel)
                }
                .padding(.top , 40)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .task {
                if user_id.isEmpty{
                    user_id = loggedinUser.id
                }
                getUserProfile()
            } 
            .toast(isPresenting: $isToastMessage){
                AlertToast(type: .regular, title: toastMessage)
            }
            .actionSheet(isPresented: $show_confirmationAlert) {
                SwiftUI.ActionSheet(
                        title: Text(""),
                        message: Text("Are you certain you want to log out?"),
                        buttons: [
                            .destructive(Text("Logout")) {
                                logoutButtonPressed()
                            },
                            .cancel(),
                        ]
                    )
                }
        }
    }
    
    //MARK: - All functions here
    
    //GetUserProfile information
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
    
    // Logout api call
    func logoutButtonPressed(){
        UserApiCall().logOut { _response, isSuccess in
            if isSuccess{
                UserDefaults.saveJSON(JSON(), .userDetails)
                isLoggedOut.toggle()
            }else{
                toastMessage = _response.strResMsg
                isToastMessage.toggle()
            }
        }
    }
    
    //Send connect request to liked user
    func sendConectionRequiest(){
        notificationApiCall().sendConectionRequest(secondParson_id: userModel.id) { _response in
            if _response.isSuccess{
                toastMessage = "Your conection request has been successfully send."
                isToastMessage.toggle()
            }else{
                toastMessage = _response.strResMsg
                isToastMessage.toggle() 
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
