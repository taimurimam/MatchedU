//
//  Notifications.swift
//  MatchedU
//
//  Created by Taimur imam on 28/02/24.
//

import SwiftUI

enum Notification_Type : Int{
    case likestory
    case connection_request
    case conection_requestAccepted 
    case profile_updated
}

struct Notifications: View {
    @State var notifications = [Notification_model]()
    @State private var isLoading = false

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.app_white, .background_gradient_top]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack{
                HeaderView(title: "Notifications" , hideBackBtn: true)
            ScrollView{
                LazyVStack(spacing: 5){
                    ForEach(notifications , id: \.id) { notification in
                        NotificationCell(notification_Model: notification)
                            .onAppear(){
                                if notification.id == self.notifications.last?.id && !isLoading {
                                    isLoading = true
                                    getNotificationList()
                                }
                            }
                        }
                        if isLoading{
                            Text("Loading.....")
                                .foregroundStyle(Color.app_black)
                        }
                    }
                }
            }
        }
        .task {
            getNotificationList()
        }
    }
    
    //MARK: - all function will be here
    func getNotificationList(){
        if !isLoading{
            showHud()
        }
        notificationApiCall().notificationList { _response in
            if _response.isSuccess{
                self.notifications = _response.completeJsonResp["data"]["notification_list"].arrayValue.map { Notification_model(from: $0 )}
                isLoading = false
            }else{
                print("some bad happned...")
            }
        }
    }
    
}

#Preview {
    Notifications()
}
