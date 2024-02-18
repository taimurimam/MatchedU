//
//  ResetPassword.swift
//  THE WiLL
//
//  Created by Taimur imam on 13/09/23.
//

import SwiftUI

struct ResetPassword: View {
    @State var tostMesessage = "Confirm password did not matched"
    @State private var isTostPopUp  = false
    @State var password = ""
    @State var confirm_password = ""
    var email = ""
    @State private var isPaswrd_changed = false
    var body: some View {
        ZStack{
            BackgroundView(type: .gray)
            VStack{
                HeaderView(title: "Reset Password")
                VStack(alignment: .leading, spacing: 20){
                    Text("Please reset your password")
                        .foregroundColor(.black)
                        .font(.appFont(type: .Regular, size: 21))
                        .padding(.horizontal , 30)
                        .padding(.bottom , 30)
                    InputField(text: $password, inputFieldType: .password, placeholder: "New Password" )
                        .padding(.horizontal)

                    InputField(text: $confirm_password, inputFieldType: .password, placeholder: "Confirm New Password" )
                        .padding(.horizontal)
                    Button{
                        updatePassword()
                    }label: {
                        Large_Blue_Button(title: "Reset Password")
                            .padding(.horizontal , 30)
                            .padding(.top , 150)
                    }
                }
                .padding(.top , 20)
                Spacer()
            }
                .navigationBarHidden(true)
            
            if isPaswrd_changed{
                PasswordResetedMessage(isHideCongratulationpopup: $isPaswrd_changed)
            }
            
        }
    }
    
    //MARK: - API Calls
 
    func updatePassword(){
        if password.isEmpty{
            tostMesessage = "Please enter your new password."
            isTostPopUp.toggle()
        }else
        if password != confirm_password{
            tostMesessage = "Confirm password did not match"
            isTostPopUp.toggle()
        } else{
            letsChangePassword()
        }
    }
    
    func letsChangePassword(){
        UserApiCall().changePassword(new_password: password, email: email) { _response, isSuccess in
            if isSuccess{
                isPaswrd_changed.toggle()
            }else{
                tostMesessage = _response.strResMsg
                isTostPopUp.toggle()
            }
        }
    }
    
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword()
    }
}
