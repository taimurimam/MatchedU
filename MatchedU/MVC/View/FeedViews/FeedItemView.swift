//
//  FeedItemView.swift
//  WonderLive
//  Created by Taimur imam on 22/12/23.

import SwiftUI
import SwiftyJSON

struct FeedItemView: View {
    
    var feed_model : Feed_Model
    let feedDeleted: (_ deletedFeed: Feed_Model ) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            FeedProfileView(feed_model: feed_model) 
            NavigationLink(destination: FeedDetails(feed_Model: feed_model, feedDeleted: { deletedFeed in
                self.feedDeleted(deletedFeed)
                
            })){
                VStack(alignment: .leading, spacing: 12) {
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
            
            HStack (spacing: 20){
                Button(action: {
                    acceptRejectApiCall(type: "1")
                }) {
                    Image("accept")
                        .foregroundStyle(Color.primary_color)
                        .font(.appFont(type: .Regular, size: 22))
                 }
                if feed_model.responseStatus == .notResponded{
                    Button(action: {
                        acceptRejectApiCall(type: "2")
                    }) {
                        Image("reject")
                            .foregroundStyle(Color.primary_color)
                            .font(.appFont(type: .Regular, size: 22))
                    }
                }
            }
            .padding(.horizontal)
            
             Divider()
                .padding(.top)
        }
    }
 
    //MARK: - All Function will be here ..........
    
    func acceptRejectApiCall(type: String){
        FeedApiCall().likeFeed(feed_id: feed_model.id, type: type) { _response in
            if _response.isSuccess {
                if type == "2"{
                    self.feedDeleted(feed_model)
                }
            }else{
                print("some issue happned")
            }
        }
    }
    
}

#Preview {
    FeedItemView(feed_model: Feed_Model(from: JSON()), feedDeleted: {deletedFeed in
        
    })
}
