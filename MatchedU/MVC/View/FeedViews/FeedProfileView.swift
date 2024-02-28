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
    
    var body: some View {
        HStack {
            // Left side: Profile details
            HStack(spacing: 8) {
                if isBackButton{
                    BackButton()
                        .padding(.top)
                }
                // Profile image
                ProfileImage(url: feed_model.feed_owner.profile_img , width: 50, leading_padding: 0)
                    .overlay(
                        Circle().stroke(Color.primary_color, lineWidth: 1.0)
                    )
                // Title and subtitle
                VStack(alignment: .leading, spacing: 7) {
                    Text(feed_model.feed_owner.name)
                        .font(.appFont(type: .medium, size: 18))
                        .foregroundStyle(Color.primary_color)
                    Text(feed_model.feed_time )
                        .font(.app_body_Font(type: .lite, size: 11))
                        .foregroundColor(.black)
                }
                .padding(.leading , 5) 
            }
            .padding(.leading , isBackButton ? 5 : 25)
            
            Spacer()
            if showOptionButton{
                // Right side: More button
                Button(action: {
                    // Handle more button action
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
    }
}

#Preview {
    FeedProfileView(feed_model: Feed_Model(from: JSON()))
}
