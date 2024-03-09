//
//  FeedProfileView.swift
//  WonderLive
//
//  Created by Taimur imam on 22/12/23.
//

import SwiftUI
import SwiftyJSON

struct FeedProfileView: View {
    var feed_model : Feed_Model
    var showOptionButton = true
    var isBackButton = false
    @State private var toastMessage = ""
    @State private var isToastMessage = false
    @State private var isShowingActionSheet = false
    var body: some View {
        HStack {
            // Left side: Profile details
            HStack(spacing: 8) {
                if isBackButton{
                    BackButton()
                        .padding(.top)
                }
                // Profile image
                ProfileImage(url: feed_model.feed_owner.profile_img , width: 50, leading_padding: 0 , isNaviagtion: true , user_id: feed_model.feed_owner.user_id )
                    .overlay(
                        Circle().stroke(Color.primary_color, lineWidth: 1.0)
                    )
                // Title and subtitle
                VStack(alignment: .leading, spacing: 7) {
                    Text(feed_model.feed_owner.name)
                        .font(.appFont(type: .medium, size: 18))
                        .foregroundStyle(Color.primary_color)
                    TimerText(timeString: feed_model.feed_time)
                }
                .padding(.leading , 5) 
            }
            .padding(.leading , isBackButton ? 5 : 15)
            
            Spacer()
            if showOptionButton{
                // Right side: More button
                Button(action: {
                    // Handle more button action
                    isShowingActionSheet.toggle()
                }) {
                    Image(systemName: "ellipsis")
                        .padding(.vertical)
                        .padding(.trailing , 2)
                        .foregroundColor(.app_black)
                        .font(.appFont(type: .Bold, size: 22))
                }
                .padding(.trailing)
            }
        }
        .background(.clear)
        .padding(.vertical , 7)
        .actionSheet(isPresented: $isShowingActionSheet) {
            SwiftUI.ActionSheet(title: Text("Select option"), buttons: [
                        .destructive(Text("Report this post"), action: {
                            reportFeed()
                        }),
                        .destructive(Text("Block \(feed_model.feed_owner.name)"), action: {
                            bloackUser()
                        }),
                        .cancel()
                    ])
                }
    }
    
    
    func reportFeed(){
        FeedApiCall().reportFeed(feed_id: feed_model.id) { _response in
            if _response.isSuccess{
                toastMessage = "We have received your report regarding this post"
                isToastMessage.toggle()
            }else{
                toastMessage = _response.strResMsg
                isToastMessage.toggle()
            }
        }
    }
    
    func bloackUser(){
        UserApiCall().blockUser(blocked_user_id: feed_model.feed_owner.user_id) { _response, isSuccess in
            if isSuccess{
                toastMessage = "You have successfully blocked \(feed_model.feed_owner.name)"
                isToastMessage.toggle()
            }else{
                toastMessage = _response.strResMsg
                isToastMessage.toggle()
            }
        }
    }
    
}

#Preview {
    FeedProfileView(feed_model: Feed_Model(from: JSON()))
}
