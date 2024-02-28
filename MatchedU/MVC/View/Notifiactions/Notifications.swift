//
//  Notifications.swift
//  MatchedU
//
//  Created by Taimur imam on 28/02/24.
//

import SwiftUI

enum Notification_Type : Int{
    case likestory
    case followed
    case profile_updated 
}

struct Notifications: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.app_white, .background_gradient_top]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack{
                HeaderView(title: "Notifications" , hideBackBtn: true)
            ScrollView{
                LazyVStack(spacing:5){
                
                    NotificationCell()
                    NotificationCell()
                    NotificationCell()
                    NotificationCell()
                    NotificationCell()
                    NotificationCell()
                    NotificationCell()
                    NotificationCell()

                    }
                }
            }
        }
    }
}

#Preview {
    Notifications()
}
