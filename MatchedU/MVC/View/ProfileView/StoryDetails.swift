//
//  StoryDetails.swift
//  MatchedU
//
//  Created by Taimur imam on 18/02/24.
//

import SwiftUI
import SwiftyJSON
import AlertToast

struct StoryDetails: View {
    
    var storyModel = StoryModel(from: JSON())
    @State private var isAlertToast = false
    @State private var toastMessage = ""
    @State private var showAlert = false
    @State private var deleteConfirmAlert = false

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
                    LinearGradient(gradient: Gradient(colors: [.app_black.opacity(0.0), .app_black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
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
                ZStack(alignment: .trailing){
                    HeaderView(title: "Story")
                    if storyModel.isMyStory{
                        Button{
                            showAlert.toggle()
                        }label: {
                            Image("trash")
                                .btnActionStyle()
                        }
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $isAlertToast){
                AlertToast(type: .regular, title: toastMessage)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to delete this story?"),
                    primaryButton: .default(Text("Delete")) {
                        letsDeleteTheStory()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            if deleteConfirmAlert{
                CustomAlert(isHide: $deleteConfirmAlert , message: "Your story has been deleted", title: "Deleted", alerttype: .storyDeleted)
            }
        }
    }
    
    
    //MARK: - All Functions will be here
    
    func letsDeleteTheStory(){
        StoryApiCall().DeleteStory(story_id: storyModel.id) { _response in
            if _response.isSuccess{
                deleteConfirmAlert.toggle()
            }else
            {
                toastMessage = _response.strResMsg
                isAlertToast.toggle()
            }
        }
    }
    
    
}

#Preview {
    StoryDetails()
}
