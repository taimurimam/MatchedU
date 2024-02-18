
//  ForgetPassword.swift
//  THE WiLL
//  Created by Taimur imam on 04/09/23.

import SwiftUI
import AlertToast 
struct ForgetPassword: View {
    @State var tostMesessage = "Please enter valid email"
    @State private var isTostPopUp  = false
    @State private var isNavActive  = false
    @State private var phone_no = ""
    var otp_for = OTP_for.forgetPassword

    @State var email = ""
    var body: some View {
        ZStack{
            BackgroundView(type: .blue)
            VStack{
                HeaderView(title: "Password Restore")
                VStack(spacing: 25){
                    Text("Please Enter your email, We will send OTP to your email.")
                        .foregroundStyle(Color.app_blue)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .font(.appFont(type: .Regular, size: 17))

                    InputField(text: $email , inputFieldType: .email, placeholder: "Email")
                        .padding(.horizontal,10)
                    NavigationLink(destination: OTPverification(otp_for: otp_for, email: email, isMobile: true) , isActive : $isNavActive ){}
                    
                    Button{
                        if email.isStudentEmail{
                            SendOtpToTheEmail()
                        }else{
                            tostMesessage = "Please enter valid email"
                            isTostPopUp.toggle()
                        }
                    }label: {
                        Large_Blue_Button(title: "Send OTP")
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                .padding(.top , 80)
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $isTostPopUp){
                AlertToast(type: .regular, title: tostMesessage)
            }
        }
    }
    
    
    // All Function Will be call here
    
    func SendOtpToTheEmail(){
        UserApiCall().forgetPasswordOTPSend(email: email) { _response, isSuccess in
            if isSuccess{
                isNavActive.toggle()
            }else{
                tostMesessage = _response.strResMsg
                isTostPopUp.toggle()
            }
        }
    }
     
    
    
}

struct ForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassword()
    }
}
