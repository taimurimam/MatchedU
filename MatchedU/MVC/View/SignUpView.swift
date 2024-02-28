//
//  SigninView.swift
//  MatchedU
//
//  Created by Taimur imam on 13/02/24.
//

import SwiftUI
import AlertToast


struct SignUpView: View {
    @State var Name = ""
    @State var phone_no = ""
    @State var confimr_password = ""
    @State var password = ""
    @State var email = ""
    @State var isTermsAccepted = false
    @Environment(\.dismiss) var dismiss
    @State private var isTostPopUp  = false
    @State private var tostMessage  = "Please enter required fields"
    @State var isLogInSucced = false
    @State private var dateOfBirth = Date()
    @State var waringMessage = ""
    @State var showAlert = false
    @State var showToast = false
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: dateOfBirth)
    }
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                HeaderView(title: "Signup")
                ScrollView{
                    VStack (){
                        HStack{
                            Image("LogoSignUp")
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                        VStack(spacing: 20){
                            InputField(text: $Name , inputFieldType: .text, placeholder: "Full Name")
                            InputField(text: $email , inputFieldType: .email, placeholder: "Email")
                            InputDate(birthDate: $dateOfBirth)
                            InputField(text: $password , inputFieldType: .password, placeholder: "Password")
                            InputField(text: $confimr_password , inputFieldType: .password, placeholder: "Confirm Password")
                            HStack{
                                Image(isTermsAccepted ? "terms_active" : "terms_inactive")
                                    .onTapGesture {
                                        isTermsAccepted.toggle()
                                    }
                                Text("I agree all")
                                    .foregroundColor(.placeholder)
                                    .font(.appFont(type: .lite, size: 16))
                                
                                Text("Terms and conditions")
                                    .padding(.vertical)
                                    .foregroundColor(.app_blue)
                                    .font(.appFont(type: .lite, size: 16))
                                    .underline()
                                
                                Spacer()
                            }
                            .padding(.top , 0)
                            .padding(.horizontal)
                        }
                        .padding(.horizontal , 5)
                        .padding(.top , 20)
                        Button{
                            signupPressed()
                        }label: {
                            Large_Blue_Button(title: "Signup")
                                .padding(.horizontal)
                        }
                        Spacer()
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(.placeholder)
                                .font(.appFont(type: .lite, size: 16))
                            Button{
                                dismiss()
                            }label: {
                                Text("Login")
                                    .foregroundStyle(Color.app_blue)
                                    .font(.appFont(type: .medium, size: 17))
                            }
                        }
                        .padding(.top, 15)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $showToast){
                AlertToast(type: .regular, title: waringMessage)
            }
            
            // Custom Alert *****
            if showAlert{
                CustomAlert(isHide: $showAlert  , alerttype : .AccountCreated)
            }
        }
    }
    
    //MARK: - All Functions will be call here
    
    func signupPressed(){
        hideKeyboard()
        if !isTermsAccepted{
            waringMessage = "To create an account you have to agree on our tems and conditions"
            showToast.toggle()
        }else
        if Name.isEmpty{
            waringMessage = "Please enter your name"
            showToast.toggle()

        }else
        if !email.isStudentEmail{
            waringMessage = "Please enter your email (email has to be student email with .edu)."
            showToast.toggle()

        }else
        if password.isEmpty{
            waringMessage = "Please enter your password"
            showToast.toggle()

        }else
        if password != confimr_password{
            waringMessage = "Your password and confirm password has to be the same"
            showToast.toggle()

        }else{
            letsCraetNewAccount()
        }
    }
    
    func letsCraetNewAccount(){
        
        let params = [
            "email" : email.lowercased() ,
            "password" : password,
            "name" : Name ,
            "dob" : formattedDate,
            "tag" : ["cricket" , "footbal" , "politics"]
        ] as [String : Any]
        
        UserApiCall().registerNewAccount(params: params)  { _response , isSuccess   in
            if isSuccess{
                print(_response.jsonResp)
                withAnimation{
                    showAlert.toggle()
                }
            }else{
                print("Account faild")
                waringMessage = _response.strResMsg
                showToast.toggle()
            }
        }
    }
}

#Preview {
    SignUpView()
}




