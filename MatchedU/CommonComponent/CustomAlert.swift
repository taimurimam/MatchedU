//
//  CustomAlert.swift
//  WonderLive
//
//  Created by Taimur imam on 13/12/23.
//

import SwiftUI

enum CustomAlertType : Int{
    case AccountCreated = 0
    case forgetPassword_EmailSend
    case profileUpdated
}

struct CustomAlertMode {
    var title = ""
    var description = ""
    var logo = ""
    var alertType = CustomAlertType.AccountCreated
}


struct CustomAlert: View {
    @Binding var isHide : Bool
    var message = ""
    var title = ""
    var alerttype = CustomAlertType.AccountCreated
    var body: some View {
        ZStack{
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            customAlertUI(alerttype :  alerttype , message: message, title: title, isHide: $isHide)
        }
    }
}

#Preview {
    CustomAlert(isHide: .constant(false))
}


struct customAlertUI: View {
    var alerttype = CustomAlertType.AccountCreated
    var message = ""
    var title = ""
    var customAlertModel : CustomAlertMode{
        if alerttype == .AccountCreated{
            return CustomAlertMode(title: "Congratulation!" , description:  "Your account has been created, We Have Send Confimation To Your Email Address." , logo: "tick_mark", alertType: alerttype)
        }else
        {
            return CustomAlertMode(title: title , description: message , logo: "tick_mark")
        }
    }
    
    @Binding var isHide : Bool
    @State var isNavigateToLogin = false
    var body: some View {
        ZStack(alignment:.topTrailing){
           
        VStack {
            ZStack{
                Color.primary_color
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    .cornerRadius(50)
                Image(customAlertModel.logo)
            }
            .padding(.top , 30)
            .padding(.vertical , 5)
            
            VStack (spacing:10){
                Text(customAlertModel.title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .font(.appFont(type: .Bold, size: 19))
                    .padding(.bottom , 5)
                    
                
                Text(customAlertModel.description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.bottom , 50)
                    .font(.appFont(type: .Regular, size: 17))
                    .padding(.horizontal , 5)
                    .lineSpacing(9)
            }
            .frame(minWidth: 100, maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
        .background(.black.opacity(0.85))
        .cornerRadius(20)
        .padding()
        .padding(.horizontal)
            if alerttype != .AccountCreated{
                Image(systemName: "xmark")
                    .padding(.trailing , 60)
                    .padding(.top , 40)
                    .foregroundStyle(Color.app_white)
                    .onTapGesture {
                        isHide.toggle()
                    }
            }else
            {
                NavigationLink(destination: LoginView()){
                    Image(systemName: "xmark")
                        .padding(.trailing , 60)
                        .padding(.top , 40)
                        .foregroundStyle(Color.app_white)
//                        .onTapGesture {
//                          //  isHide.toggle()
//                    }
                }
            }
       }
    }
}
