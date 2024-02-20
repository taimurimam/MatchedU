//
//  FeedDetails.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import SwiftUI
import SwiftyJSON
import AlertToast

struct FeedDetails: View {
    
    var feed_Model = Feed_Model(from: JSON())
    @State private var isAlertToast = false
    @State private var toastMessage = ""
    @State private var showAlert = false
    @State private var deleteConfirmAlert = false
    
    var body: some View {
        ZStack{
            Color.app_white
                .ignoresSafeArea()
            ZStack{
                Asyn_ImageView(url: feed_Model.feed_img , width: 270 , height: 480 , cornerRedious: 0)
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
                    HStack{
                        FeedProfileView(feed_model: feed_Model , showOptionButton: !feed_Model.isMyStory , isBackButton: true)
                        Spacer()
                        if feed_Model.isMyStory{
                            Button{
                                showAlert.toggle()
                            }label: {
                                Image("trash")
                                    .btnActionStyle()
                                    .padding(.top)
                            }
                        }
                    }.offset(y:-30)
                    Spacer()
                    Text(feed_Model.feedText)
                        .font(.app_body_Font(type: .Regular, size: 17))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal)
                        .lineSpacing(6)
                        .padding(.bottom , 30)
                }
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $isAlertToast){
                AlertToast(type: .regular, title: toastMessage)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to delete this post?"),
                    primaryButton: .default(Text("Delete")) {
                        // Perform deletion action here
                        letsDeleteThepost()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            if deleteConfirmAlert{
                CustomAlert(isHide: $deleteConfirmAlert , message: "Your post has been deleted", title: "Deleted", alerttype: .storyDeleted)
            }
        }
    }
    
    
    //MARK: - All Functions will be here
    
    func letsDeleteThepost(){
        FeedApiCall().deleteFeed(feed_id: feed_Model.id) { _response in
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
    FeedDetails()
}
