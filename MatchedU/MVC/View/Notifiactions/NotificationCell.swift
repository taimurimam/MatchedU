//
//  NotificationCell.swift
//  MatchedU
//
//  Created by Taimur imam on 28/02/24.
//

import SwiftUI

struct NotificationCell: View {
    
    var body: some View {
        HStack(spacing: 15){
            ZStack(alignment:.trailing){
                ProfileImage(url: "" , width: 44)
                Image("love_notification")
                    .offset(x: 5  ,y: 12)
            }
            VStack(alignment:.leading , spacing: 7){
                Text("Taimur liked your story.")
                    .foregroundStyle(Color.black)
                    .font(.app_body_Font(type: .Regular, size: 17))
                Text("5 min ago")
                    .foregroundStyle(Color.text_secondary_color)
                    .font(.app_body_Font(type: .Regular, size: 14))
            }
            Spacer()
        }
        .padding(.vertical , 10)
       // .background(Color.app_blue.opacity(0.4))
    }
    
}

#Preview {
    NotificationCell()
}
