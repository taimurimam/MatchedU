//
//  ProfileStoryView.swift
//  MatchedU
//  Created by Taimur imam on 16/02/24.

import SwiftUI
import SwiftyJSON

struct ProfileStoryView: View {
    var isEditable = false
    @Binding var  userModel : UserModel
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("Story")
                    .profileSectionTitleStyle()
                    .padding(.leading , 20)
                Spacer()
                if userModel.isMyProfile{
                    BtnCreatStory()
                        .padding(.trailing)
                }
            }
            .padding(.top , 20)
            ScrollView(){
                LazyVStack(spacing: 20){
                    ForEach(userModel.stories , id: \.id ) { story in
                        StoryCard(storyModel: story, isEditable : isEditable)
                    }
                }
            }
        }
        .task {
            
        }
    }
}

#Preview {
    ProfileView()
}

struct StoryCard: View {
    var storyModel = StoryModel(from: JSON())
    var isEditable = false
    var isForCreatNew = false
    var creteNew = ""
    var body: some View {
            ZStack(alignment:.bottomTrailing){
               // NavigationLink(destination: StoryDetails(storyModel: storyModel)){
                Asyn_ImageView(url: storyModel.imgUrl , width: Int(UIScreen.main.bounds.width-20) , height: Int(UIScreen.main.bounds.width + 40) , cornerRedious: 12)
                        .frame(width: UIScreen.main.bounds.width - 20  , height:UIScreen.main.bounds.width + 40 )
                        .clipped()
                        .shadow(color: .black.opacity(0.5), radius: 10 , x: 4 , y: 8)
                        .cornerRadius(12)
                
              //  }
                Button{
                    likeStory()
                }label: {
                    Image(systemName: (storyModel.iLiked ? "heart.fill" : "heart"))
                        .foregroundColor(.red.opacity(storyModel.iLiked ? 1.0 : 0.5))
                        .font(.app_body_Font(type: .lite, size: 30))
                        .frame(width: 50 , height: 50)
                        .background(Color.off_white)
                        .shadow(color: .black.opacity(0.1), radius: 10 , x: 4 , y: 8)
                        .clipShape(Circle())
                        .padding(10)
                }
            }
        
    }
    
    //MARK: - All function will be here
    
    func deleteTheStory(){
        StoryApiCall().DeleteStory(story_id: storyModel.id) { _response in
            if _response.isSuccess{
                
            }else{
                
            }
        }
    }
    
    func likeStory(){
        StoryApiCall().storyLiked(story_id: storyModel.id) { _response in
            if _response.isSuccess{
                print("Liked")
            }else{
                print(_response.strResMsg)
            }
        }
    }
    
    
}
