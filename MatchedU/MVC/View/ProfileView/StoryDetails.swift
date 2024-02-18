//
//  StoryDetails.swift
//  MatchedU
//
//  Created by Taimur imam on 18/02/24.
//

import SwiftUI
import SwiftyJSON
struct StoryDetails: View {
    
    var storyModel = StoryModel(from: JSON())
    
    var body: some View {
        ZStack{
            Color.app_white
                .ignoresSafeArea()
            ZStack{
                Asyn_ImageView(url: storyModel.imgUrl , width: 270 , height: 480 , cornerRedious: 0)
                    .frame( height: 480)
                    .frame(maxWidth: .infinity)
                    .clipped()
                VStack{
                    Spacer()
                    LinearGradient(gradient: Gradient(colors: [.app_white.opacity(0.1), .app_black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 250)
                }
                .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text(storyModel.title)
                        .font(.appFont(type: .Regular, size: 18))
                        .foregroundStyle(Color.white)
                        .padding(.bottom , 30)
                }
            }
            VStack{
                HeaderView(title: "Story")
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    StoryDetails()
}
