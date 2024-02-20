//
//  ProfileStoryView.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.

import SwiftUI
import SwiftyJSON 
struct ProfileStoryView: View {
  var isEditable = false
  var arrStory = [StoryModel]()
    var body: some View {
        VStack(alignment:.leading){
            Text("My Story")
                .profileSectionTitleStyle()
                .padding(.leading)
            ScrollView(.horizontal){
                LazyHStack(spacing: 13){
                    ForEach(arrStory , id: \.id ) { story in
                        NavigationLink(destination: StoryDetails(storyModel: story)){
                            StoryCard(storyModel: story, isEditable : isEditable)
                        }
                    }
                    StoryCard(isForCreatNew: true)
                }
                .padding(.leading)
            }
            .frame(height: 300)
        }
        .task {
            
        }
    }
}

#Preview {
    ProfileStoryView()
}

struct StoryCard: View {
    var storyModel = StoryModel(from: JSON())
    var isEditable = false
    var isForCreatNew = false
    var creteNew = ""
    
    var body: some View {
        VStack(alignment: .leading , spacing: 10){
            Text(isForCreatNew ? creteNew : storyModel.title)
                .foregroundStyle(Color.app_black)
                .font(.app_body_Font(type: .Regular, size: 17) )
            ZStack(alignment:.bottomTrailing){
                if isForCreatNew{
                    NavigationLink(destination: CreatStory()) {
                        PlusButton()
                    }
                }else{
                    Asyn_ImageView(url: storyModel.imgUrl , width: 270 , height: 200 , cornerRedious: 12)
                        .frame(width: 270 , height: 200)
                        .clipped()
                        .cornerRadius(12) 
                }
            }
        }
        .frame(width: 300 , height: 250)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .app_black.opacity(0.1), radius: 10 , x: 4 , y: 8)
    }
    
    //MARK: - All function will be here
    
    func deleteTheStory(){
        StoryApiCall().DeleteStory(story_id: storyModel.id) { _response in
            if _response.isSuccess{
                
            }else{
                
            }
        }
    }
    
    
}
