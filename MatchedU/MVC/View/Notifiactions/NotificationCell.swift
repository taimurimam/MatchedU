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
        if notification_Model.notificationType == .connection_request || notification_Model.notificationType == .conection_requestAccepted{
            ConnectCell(notification_Model: notification_Model)
        }else
        if notification_Model.notificationType == .likestory{
            NavigationLink(destination: FeedDetails( feed_id: notification_Model.feed_id, feedDeleted: {deletedFeed in })){
                NotificationCellLike(notification_Model: notification_Model)
            }
        }else {
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
                
                if notification_Model.conection_status == .rejected{
                    Text("You have rejected conection request of  \(notification_Model.sender_name)")
                        .foregroundStyle(Color.black)
                        .font(.app_body_Font(type: .Regular, size: 17))
                }
                if notification_Model.conection_status == .conceted{
                   Text("You are conected with \(notification_Model.sender_name)")
                       .foregroundStyle(Color.black)
                       .font(.app_body_Font(type: .Regular, size: 17))
               }else
                if notification_Model.conection_status == .requestPending{ // IF Conection request still pending need all info and buttons
                   Text("\(notification_Model.sender_name) want to connect with you.")
                       .foregroundStyle(Color.black)
                       .font(.app_body_Font(type: .Regular, size: 17))
                   HStack(spacing:10){ //
                       Image("teacher")
                       Text(notification_Model.graguation_year)
                       Image("award")
                           .padding(.leading)
                       Text(notification_Model.collage)
                   }
                   .foregroundStyle(Color.text_secondary_color)
                   .font(.app_body_Font(type: .Regular, size: 16))
                   
                   HStack(spacing:10){
                       Button{
                           conectionRequestResponse(response: "2")
                       }label: {
                           Text("Reject")
                               .btnRejectStyle()
                       }
                       
                       Button{
                           conectionRequestResponse(response: "1")
                       }label: {
                           Text("Accept")
                               .btnacceptStyle()
                       }
                   }
                   .font(.app_body_Font(type: .Regular, size: 18))
               }
                Text(notification_Model.time)
                    .foregroundStyle(Color.text_secondary_color)
                    .font(.app_body_Font(type: .Regular, size: 14))
            }
            Spacer()
        }
        .padding(.vertical , 10)
    }
    
    //MARK: - All function will be go here *******
    
    func conectionRequestResponse(response : String){
        notificationApiCall().conectionRequestResponse(secondParson_id: notification_Model.sender_user_id, responseType: response) { _response in
            
        }
    }
    

}
