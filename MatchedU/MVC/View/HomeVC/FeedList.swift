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
    let img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.Xm1EXmPOVQQajFrYh3F_WAHaHa%26pid%3DApi&f=1&ipt=575d8267b08e80241bbf7780a7b1e9474b97a22045f7cfea96af1ca9d5ca0bfa&ipo=images"
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                HStack{
                    ProfileImage(url: loggedinUser.profile_image , width: 30, leading_padding: 0)
                       
                        .padding(.leading , 15)

                    Text("Hi! \(loggedinUser.name)")
                        .foregroundStyle(Color.primary_color)
                        .font(.appFont(type: .Regular, size: 28))
                        Spacer()
                    btnSearch()
                }
                .frame(height: 64)
                .background(Color.white )
                ZStack(alignment:.bottomTrailing){
                    ScrollView {
                        LazyVStack{
                            ForEach(1...30, id: \.self) { index in
                                FeedItemView(feed_model: feed_Model)
                            }
                        }
                    }
                    .offset(y:-8)
                    Button{
                        btnPlusTapped()
                    }label: {
                        Image(systemName: "plus")
                            .btnCreatPostStyle()
                    }
                }
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    //MARK: -  All Function will be here ********
    
    func btnPlusTapped(){
        
    }
}

#Preview {
    FeedList()
}
