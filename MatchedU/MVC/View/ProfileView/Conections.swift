
//  Conections.swift
//  MatchedU
//  Created by Taimur imam on 02/03/24.

import SwiftUI
struct Conections: View {
    let url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.s3RJ4bcuEf9d2BBzCCB_0wHaHa%26pid%3DApi&f=1&ipt=c3b7734401df1a6b7b5b66de57c10c5cbb67cb0e926cfe9561f7ed815009bbd8&ipo=images"
    var body: some View {
        VStack(spacing:15){
            HStack{
                Text("My Connections")
                    .profileSectionTitleStyle()
                Spacer()
                NavigationLink(destination: SeachView( isFromConection: true) ) {
                    Text("View All")
                        .padding(.horizontal)
                        .frame(height: 30)
                        .background(Color.secondary_background)
                        .clipShape(Capsule())
                        .foregroundStyle(Color.app_white)
                }
            }
            // profile circles images
            HStack{
                ForEach(0..<5, id: \.self) { index in
                    ProfileImage(url: url , width: 48 , leading_padding : 0)
                        .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(  Color.app_white , lineWidth: 2.5)
                        )
                        .offset(x: -CGFloat((index * 15)))
                    }
                Text("+23")
                    .foregroundStyle(Color.black)
                    .font(.app_body_Font(type: .Regular, size: 21))
                    .offset(x: -CGFloat((4 * 15)))

                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    Conections()
}