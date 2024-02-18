//
//  OTPverification.swift
//  THE WiLL
//
//  Created by Taimur imam on 13/09/23.
//

import SwiftUI
import SwiftyJSON
import AlertToast

enum FocusedField {
    case opt1, opt2,opt3,opt4
}

struct OTPTextField: View{
    var email = ""
    @Binding var value : String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View{
        ZStack{
            Image( isTextFieldFocused ? "opt_focused" :  "opt_empty")
            if value.isEmpty {
                Text(isTextFieldFocused ? "" : "-")
                    .foregroundColor(.placeholder)
            }
            TextField("" , text: $value)
                .frame(width:55 , height: 55)
                .multilineTextAlignment(.center)
                .foregroundColor(.app_blue)
                .focused($isTextFieldFocused)
                .keyboardType(.numberPad)
                .accentColor(.app_blue)
            
        }
        .frame(width:55 , height: 55)
        .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(!value.isEmpty ? Color.app_blue : .placeholder, lineWidth: 1.0)
            )
    }
}

enum OTP_for : Int {
    case forgetPassword = 0
    case messageVerify
}

struct OTPverification: View {
    enum Field: Hashable {
        case otp1
        case otp2
        case otp3
        case otp4
    }
    var OTP : String {
        return otp1+otp2+otp3+otp4
    }
    
    @State var tostMesessage = "Please enter valid email"
    var otp_for = OTP_for.forgetPassword 
    @State private var isTostPopUp  = false
    @FocusState private var focusedField: Field?
    @State private var showToast = false
    @State private var toastMsg = ""
    var isfromForgetPassword = false
    @State var timeRemaining = 60
    @State var otp1 = ""
    @State var otp2 = ""
    @State var otp3 = ""
    @State var otp4 = ""
    
    var isOtpEntered : Bool{
        if otp1.isEmpty || otp2.isEmpty || otp3.isEmpty || otp4.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    var email: String
    var isMobile: Bool
    
    @State private var moveToTarget = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            BackgroundView(type: .gray)
            VStack{
                HeaderView(title: "Verify OTP")
                VStack(alignment: .leading){
                    Text("We have send you the verification code on")
                        .foregroundColor(.black)
                        .padding(.top , 22)
                        .font(.appFont(type: .Regular, size: 17))

                    Text(email)
                        .foregroundColor(.app_blue)
                        .padding(.top , 3)
                        .font(.system(size: 23))
                        .font(.appFont(type: .Regular, size: 17))

                }
                .padding()

                HStack{
                    Spacer()
                    OTPTextField(value: $otp1)
                        .onChange(of: otp1, perform: { newValue in
                            otpFieldDidChange(.otp1, newValue: newValue)
                        })
                        .focused($focusedField, equals: .otp1)
                    Spacer()
                    OTPTextField(value: $otp2)
                        .onChange(of: otp2, perform: { newValue in
                            otpFieldDidChange(.otp2, newValue: newValue)
                        })
                        .focused($focusedField, equals: .otp2)
                    Spacer()
                    OTPTextField(value: $otp3)
                        .onChange(of: otp3, perform: { newValue in
                            otpFieldDidChange(.otp3, newValue: newValue)
                        })
                        .focused($focusedField, equals: .otp3)
                    Spacer()
                    OTPTextField(value: $otp4)
                        .onChange(of: otp4, perform: { newValue in
                            otpFieldDidChange(.otp4, newValue: newValue)
                        })
                        .focused($focusedField, equals: .otp4)
                    Spacer()
                }
                .font(.appFont(type: .Regular, size: 26))

                .padding(.vertical , 40)
                if otp_for == .forgetPassword{
                    NavigationLink(destination: ResetPassword(email: email) , isActive: $moveToTarget){}
                }
                if otp_for == .messageVerify{
                    
                }
                Button{
                    if isOtpEntered{
                        verify_OTP()
                    }else{
                        tostMesessage = "Please enter otp"
                        isTostPopUp.toggle()
                    }
                }label: {
                    Large_Blue_Button(title: "Verify")
                        .padding(.horizontal , 30) 

                }
                Button{
                    if timeRemaining == 0{
                        re_Send_OTP()
                        timeRemaining = 60
                        print("Re send the code please..")
                    }
                }label: {
                    HStack{
                        Text("Re-send code in")
                            .foregroundColor(.placeholder)
                            .font(.appFont(type: .Regular, size: 15))

                        Text("\("0:\(timeRemaining)")")
                            .onReceive(timer) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                }
                            }
                            .foregroundColor(.app_blue)
                            .font(.appFont(type: .Regular, size: 16))

                    }
                    .padding()
                }
                Spacer()
            }
            .onAppear(){
                sendOTP(isResend: false)
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $isTostPopUp){
                AlertToast(type: .regular, title: tostMesessage)
            }

        }
    }
    
    
    func otpFieldDidChange(_ field: Field, newValue: String) {
        switch field {
        case .otp1:
            if newValue.count > 0 {
                focusedField = .otp2
            }
        case .otp2:
            if newValue.count > 0 {
                focusedField = .otp3
            } else {
                focusedField = .otp1
            }
        case .otp3:
            if newValue.count > 0 {
                focusedField = .otp4
            } else {
                focusedField = .otp2
            }
        case .otp4:
            if newValue.count > 0 {
                focusedField = nil
            } else {
                focusedField = .otp3
            }
        }
    }
    
    func sendOTP(isResend: Bool){
        UserApiCall().forgetPasswordOTPSend(email: email) { _response, isSuccess in
            
        }
    }
    
    func re_Send_OTP(){
        sendOTP(isResend: true)
    }
    
    
    //MARK: - Verify OTP
    
    func verify_OTP(){
        UserApiCall().verifyOTP(otp: OTP, email: email) { _response, isSuccess in
            if isSuccess{
                moveToTarget.toggle()
            }else
            {
                tostMesessage = _response.strResMsg
                isTostPopUp.toggle()
            }
        }
    }
    
}

struct OTPverification_Previews: PreviewProvider {
    static var previews: some View {
        OTPverification(email: "", isMobile: true)
    }
}
