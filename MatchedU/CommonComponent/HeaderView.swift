//
//  HeaderView.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.
//

import SwiftUI

struct HeaderView: View {
    var title = ""
    var icon = ""
    var rightIcon = ""
    var hideBackBtn = false
    var isEdItButton = false
    var profileImage = false
    var isSearchButton =  false
    var isDownBackBtn = false
    
    var titleColor : Color = .app_black
    var body: some View{
        ZStack{
            HStack{ // chevron.down
                if !hideBackBtn{
                    BackButton(isDownBackBtn: isDownBackBtn)
                }
                Spacer()
                if isSearchButton{
                    Image("search")
                        .btnActionStyle()
                }
                if isEdItButton{
                    NavigationLink(destination: EditProfie()) {
                        Image("edit")
                            .frame(width: 30 , height: 30)
                            .clipShape(Circle())
                            .padding(.trailing)
                            .padding(.bottom)
                    }
                }
                if !icon.isEmpty{
                    Button{
                        
                    }label: {
                        Image(icon)
                            .padding()
                            .padding(.trailing)
                    }
                }
            }.padding(.top , isiPad ? 20 : 0)
            if !title.isEmpty{
                Text(title)
                    .font(.appFont(type: .Regular, size: 22))
                    .foregroundColor(titleColor)
                    .padding(.bottom)
            }
            Spacer()
        }
        .frame(height: isiPad ? 64 : 44)
        .background(Color.clear)
       // .shadow(color: .black.opacity(0.05), radius: 1 , x: 0.0 , y: 2.5)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
