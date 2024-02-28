//
//  ContentView.swift
//  MatchedU
//
//  Created by Taimur imam on 13/02/24.
//

import SwiftUI
import AlertToast

struct LoginView: View {
    
    @State var password = ""
    @State var email = ""
    @State var search = ""
    @State var isLogInSucced  = false
    @State private var isTostPopUp  = false
    @State var resposneMessage = ""
    @State var waringMessage = ""
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                HStack{
                    Image("LogoSignUp")
                        .padding(.leading)
                    Spacer()
                }
                .padding(.top , 40)
                VStack(spacing: 20){
                    InputField(text: $email , inputFieldType: .email, placeholder: "Email")
                    InputField(text: $password , inputFieldType: .password, placeholder: "Password")
                    HStack{
                        Spacer()
                        NavigationLink(destination: ForgetPassword(otp_for: .forgetPassword)){
                            Text("Forgot Password?")
                                .foregroundColor(.placeholder)
                                .padding(.trailing)
                                .font(.appFont(type: .Regular, size: 16))

                        }
                    }
                }
                .padding(.horizontal , 5)
                .padding(.top , 60)
                NavigationLink(destination: FeedList() , isActive:$isLogInSucced ){}
                
                Button{
                    logInButtonPressed()
                }label: {
                    Large_Blue_Button(title: "Log In")
                        .padding(.horizontal)
                }
                .padding(.top , 30)
                HStack{
                    Text("Don’t have an account?")
                        .foregroundColor(.placeholder)
                        .font(.appFont(type: .lite, size: 16))

                    NavigationLink(destination: SignUpView() ){
                        Text("Signup")
                            .foregroundStyle(Color.primary_color)
                            .font(.appFont(type: .Bold, size: 17))
                    }
                }
                .padding(.top , 20)
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .toast(isPresenting: $isTostPopUp){
                AlertToast(type: .regular, title: waringMessage)
            }
        }
    }
    
    //MARK: - All Functions
    
    func logInButtonPressed(){
        hideKeyboard()
        if !email.isitValidEmail{
            waringMessage = "Email is not valid"
            isTostPopUp.toggle()
        }else
        if !email.isStudentEmail{
            waringMessage = "Email is not student email"
            isTostPopUp.toggle()
        }else
        if password.isEmpty{
            waringMessage = "Please enter password"
            isTostPopUp.toggle()
        }else{
            letsLogIn()
        }
    }
    
    func letsLogIn(){
        
        UserApiCall().Login(email: email.lowercased(), password: password) { response , isSuccess in
            if isSuccess{
                UserDefaults.saveJSON(response.completeJsonResp["data"], .userDetails)
                isLogInSucced.toggle()
            }else{
                waringMessage = response.strResMsg
                isTostPopUp.toggle()
            }
        }
    }
    
}

#Preview {
    LoginView()
}
