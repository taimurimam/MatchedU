//
//  SearchProfileCell.swift
//  MatchedU
//
//  Created by Taimur imam on 27/02/24.
//

import SwiftUI
import SwiftyJSON
struct SearchProfileCell: View {
    @Binding var userIndex : Int
    @Binding var user : UserModel
    var isFromConection = false
    let link = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.Q-ZRtH2jCAePPB7VN76XqQHaHa%26pid%3DApi&f=1&ipt=0da107b1a30a35654e2ee85c98a4415b5e0651ea459e67d31294eec788da3c9a&ipo=images"
    var body: some View {
        VStack(alignment:.leading ,  spacing: 10){ 
            Text(user.name)
                .foregroundStyle(Color.app_black)
                .font(.appFont(type: .Bold , size: 25))
            HStack(spacing:10){
                Image("award")
                Text("Graduation \(user.graduation_year)")
            }
            .foregroundStyle(Color.app_black)
            .font(.app_body_Font(type: .Regular, size: 17))
            ZStack(alignment: .bottomTrailing, content: {
                Asyn_ImageView_demo(url: user.profile_image == mediaBaseUrl ? link : user.profile_image  , width:  Int(UIScreen.main.bounds.width) - 30 , height: 350 , cornerRedious: 12)
                    .frame(width: UIScreen.main.bounds.width - 30  , height:350 )
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 10 , x: 4 , y: 8)
            })
             
            if !isFromConection{ // if from explore then this part will apear.....
                HStack{
                    VStack(alignment:.leading , spacing: 10, content: {
                        Text("About \(user.name)")
                            .padding(.leading)
                            .padding(.top)
                            .font(.app_body_Font(type: .Regular, size: 13))
                        Text(user.bio)
                            .padding(.leading)
                            .padding(.bottom)
                            .font(.app_body_Font(type: .Regular, size: 18))
                    })
                    Spacer(minLength: 1)
                }
                .foregroundStyle(Color.app_black)
                .frame(maxWidth: .infinity)
                .background(Color.secondary_background)
                .cornerRadius(12.0)
                .padding(.top , 10)
                if !user.stories.isEmpty{
                    ProfileStoryView(sendConectionRequest: {
                        sendConectionRequiest()
                    }, userModel: $user)
                }
                HStack ( spacing: 20){
                    Spacer()
                    Button(action: {
                        sendConectionRequiest()
                       
                    }) {
                        Image("accept")
                    }
                    
                    Button(action: {
                        userIndex += 1
                    }) {
                        Image("reject")
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    
    func sendConectionRequiest(){
        notificationApiCall().sendConectionRequest(secondParson_id: user.id) { _response in
            if _response.isSuccess{
                withAnimation{
                    userIndex += 1
                }
            }
        }
    }
}

#Preview {
    SeachView()
}
