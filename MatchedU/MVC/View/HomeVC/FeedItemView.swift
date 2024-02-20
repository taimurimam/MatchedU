//
//  FeedItemView.swift
//  WonderLive
//
//  Created by Taimur imam on 22/12/23.
//

import SwiftUI
import SwiftyJSON

struct FeedItemView: View {
    
    var feed_model : Feed_Model
    
    @State var likeCount = 12
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            FeedProfileView(feed_model: feed_model)
            NavigationLink(destination: FeedDetails(feed_Model: feed_model)){
                VStack(alignment: .leading, spacing: 8) {
                    if feed_model.isImage{ // if feed image contain on feed.
                        Asyn_ImageView_demo(url: feed_model.feed_img , height: 225 , cornerRedious: 0)
                            .scaledToFill()
                            .clipped()
                    }
                    Text(feed_model.feedText)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.app_black)
                        .lineSpacing(6)
                        .font(.app_body_Font(type: .lite, size: 17))
                }
            }
            HStack {
                // Like button and count
                Button(action: {
                    likeCount += 1
                }) {
                    Image(systemName: "hand.thumbsup")
                        .foregroundStyle(Color.primary_color)
                        .font(.appFont(type: .Regular, size: 22))
                 }
                Text("\(likeCount)")
                    .padding(.trailing , 5)
                    .foregroundStyle(Color.primary_color)
                    .font(.appFont(type: .medium, size: 16))
                
                // Comment button and count
                /*
                Button(action: {
                    // Handle comment action
                }) {
                    HStack{
                        Image("comments")
                            .padding(.leading , 5)
                        Text(feed_model.comment_count)
                            .foregroundStyle(Color.primary_color)
                            .font(.appFont(type: .medium, size: 13))
                    }
                }
                 */

                Spacer()
/*
                // Bookmark button
                Button(action: {
                    // Handle bookmark action
                }) {
                    Image("bookmark_active")
                        .padding(.trailing , 5) 
                }

                // Share button
                Button(action: {
                    // Handle share action
                }) {
                    Image("share")
                        .imageScale(.medium)
                        .foregroundColor(.green)
                }
                */
            }
            .padding(.horizontal)
 
             Divider()
                .padding(.top)
        }
    }
}

#Preview {
    FeedItemView(feed_model: Feed_Model(from: JSON()))
}
