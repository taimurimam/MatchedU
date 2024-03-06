
//  Conections.swift
//  MatchedU
//  Created by Taimur imam on 02/03/24.

import SwiftUI
struct Conections: View {
    @Binding var Conections : [UserModel]
    var body: some View {
        VStack(spacing:15){
            HStack{
                Text("My Connections")
                    .profileSectionTitleStyle()
                Spacer()
                if  Conections.count>0{ // if There is a conection view all will be displayed.. ..
                    NavigationLink(destination: SeachView( isFromConection: true) ) {
                        Text("View All")
                            .profileViewAllStyle()
                    }
                }
            }
            // profile circles images
            HStack{
                ForEach(0..<min(Conections.count, 5), id: \.self) { index in
                    ProfileImage(url: Conections[index].profile_image , width: 48 , leading_padding : 0 , isNaviagtion: true, user_id: Conections[index].id)
                        .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(  Color.app_white , lineWidth: 2.5)
                        )
                        .offset(x: -CGFloat((index * 15)))
                    }
                if Conections.count>5{
                    Text("\(Conections.count-5)")
                        .foregroundStyle(Color.black)
                        .font(.app_body_Font(type: .Regular, size: 21))
                        .offset(x: -CGFloat((4 * 15)))
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
