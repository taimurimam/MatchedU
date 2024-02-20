//
//  HomeView.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.
//

import SwiftUI
import SwiftyJSON

struct FeedList: View {
    var feed_Model = Feed_Model(from: JSON())

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Hi! \(loggedinUser.name)")
                        .foregroundStyle(Color.app_white)
                        .font(.appFont(type: .Regular, size: 28))
                        .padding(.leading)
                        Spacer()
                    Image("search")
                        .btnActionStyle()
                }
                .frame(height: 64)
                .background(Color.primary_color )
                ScrollView {
                    LazyVStack{
                        ForEach(1...30, id: \.self) { index in
                            NavigationLink(destination: FeedDetails(feed_Model: feed_Model )){
                                FeedItemView(feed_model: feed_Model)
                            }
                        }
                    }
                }
                .offset(y:-8)
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    FeedList()
}
