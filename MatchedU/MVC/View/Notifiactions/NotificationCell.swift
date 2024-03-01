//
//  NotificationCell.swift
//  MatchedU
//
//  Created by Taimur imam on 28/02/24.
//

import SwiftUI

struct NotificationCell: View {
    var notification_Model : Notification_model
    var body: some View {
        if notification_Model.notificationType == .connection_request{
            ConnectCell(notification_Model: notification_Model)
        }else
        if notification_Model.notificationType == .likestory{
            NotificationCellLike(notification_Model: notification_Model)
        }else{
            NotificationCellLike(notification_Model: notification_Model)
        }
    }
}

#Preview {
    Notifications()
}

struct NotificationCellLike: View {
    var notification_Model : Notification_model
    var body: some View {
        HStack(spacing: 15){
            ZStack(alignment:.trailing){
                ProfileImage(url: notification_Model.profile_img , width: 44 , isNaviagtion: true , user_id : notification_Model.sender_user_id)
                Image(notification_Model.icon)
                    .offset(x: 5  ,y: 12)
            }
            .padding(.top)
            VStack(alignment:.leading , spacing: 7){
                Text("\(notification_Model.sender_name) liked your story.")
                    .foregroundStyle(Color.black)
                    .font(.app_body_Font(type: .Regular, size: 17))
                Text(notification_Model.time)
                    .foregroundStyle(Color.text_secondary_color)
                    .font(.app_body_Font(type: .Regular, size: 14))
            }
            Spacer()
        }
        .padding(.vertical , 10)
       // .background(Color.app_blue.opacity(0.4))
    }
}


struct ConnectCell : View {
    var notification_Model : Notification_model
    var body: some View {
        HStack(alignment:.top ,  spacing: 15){
            ZStack(alignment:.trailing){
                ProfileImage(url: notification_Model.profile_img , width: 44 , isNaviagtion: true , user_id : notification_Model.sender_user_id)
                Image(notification_Model.icon)
                    .offset(x: 5  ,y: 12)
            }
            .padding(.top)
            VStack(alignment:.leading , spacing: 10){
                Text("\(notification_Model.sender_name) to connect with you.")
                    .foregroundStyle(Color.black)
                    .font(.app_body_Font(type: .Regular, size: 17))
                HStack(spacing:10){ //
                    Image("teacher")
                    Text(notification_Model.graguation_year)
                    Image("award")
                        .padding(.leading)
                    Text(notification_Model.graguation_year)
                }
                .foregroundStyle(Color.text_secondary_color)
                .font(.app_body_Font(type: .Regular, size: 16))
                
                HStack(spacing:10){
                    Button{
                        btnRejectPressed()
                    }label: {
                        Text("Reject")
                            .btnRejectStyle()
                    }
                    
                    Button{
                        btnAcceptPressed()
                    }label: {
                        Text("Accept")
                            .btnacceptStyle()
                    }
                }
                .font(.app_body_Font(type: .Regular, size: 18))
                
                Text(notification_Model.time)
                    .foregroundStyle(Color.text_secondary_color)
                    .font(.app_body_Font(type: .Regular, size: 14))
            }
            Spacer()
        }
        .padding(.vertical , 10)
    }
    
    //MARK: - All function will be go here *******
    
    func btnRejectPressed(){
        
    }
    
    func btnAcceptPressed(){
        
    }

}
