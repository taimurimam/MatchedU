//
//  CreatPost.swift
//  MatchedU
//
//  Created by Taimur imam on 21/02/24.
//

import SwiftUI
import AlertToast

struct CreatPost: View {
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    @State var showImagePickerOptions = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var toastMessage = ""
    @State private var isToast = false
    @State private var isToast_Success = false
    @State private var selectedImage: UIImage?
    let newPostSend:() -> Void
    
    var isPostButtonActive :Bool{
        if !text.isEmpty || selectedImage != nil
        {
            return true
        }else{
            return false
        }
    }
    
    var body: some View {
        ZStack{
            Color.app_white
                .ignoresSafeArea()
            VStack{
                HeaderView(title:"Creat Post" , isDownBackBtn: true)
                VStack(spacing: 30){
                    InputTextEditor(text: $text , hight: 100)
                    if selectedImage == nil{ // Image icon
                        Image(systemName: "photo.artframe")
                            .foregroundColor(.primary_color)
                            .font(.appFont(type: .Regular, size: 104))
                            .onTapGesture {
                                showImagePickerOptions.toggle()
                            }
                    }else{ // Seleceted image
                        Image(uiImage: selectedImage ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: CGFloat(Int(UIScreen.main.bounds.width)))
                            .frame(height: 260)
                            .clipped()
                            .padding(.bottom)
                            .onTapGesture {
                                showImagePickerOptions.toggle()
                            }
                    }
                    Button{
                        createPost()
                    }label: {
                        Large_Blue_Button(title: "Post")
                            .padding(.horizontal)
                    }
                    .padding(.top , 30)
                    Spacer()
                }.padding(.horizontal)
                    .padding(.top,30)
            }
            .navigationBarHidden(true)
            // Show Image Picker
            .sheet(isPresented: $showImagePicker) {
                ProfileImagePicker( image: $selectedImage , isShown: $showImagePicker, isProfileCropView: $showImagePicker , photo_for: .cover , sourceType: sourceType)
                    .onDisappear{
                    }
            }
            
            // Select Image Picker option
            .actionSheet(isPresented: $showImagePickerOptions) {
                SwiftUI.ActionSheet(
                    title: Text(""),
                    message: Text("Select Source of Message"),
                    buttons: [
                        .default(Text("Camera")) {
                            // Handle action for Option 1
                            sourceType = .camera
                            showImagePicker.toggle()
                        },
                        .default(Text("Photo Album")) {
                            sourceType = .savedPhotosAlbum
                            showImagePicker.toggle()
                        },
                        .cancel(), // Adds a cancel button
                        // You can add more buttons as needed
                    ]
                )
            } // End Image Picker
            
            .toast(isPresenting: $isToast){
                AlertToast(type: .regular, title: toastMessage)
            }
            
        }
    }
    
    //MARK - All function will be go here
    
    func createPost(){
        FeedApiCall().creatNewFeed(feedTitle: text, img: selectedImage ?? UIImage()) { _response in
            if _response.isSuccess{
                newPostSend()
                dismiss()
            }else{
                toastMessage = _response.strResMsg
                isToast.toggle()
            }
        }
    }
    
}

#Preview {
    CreatPost {
        
    }
}
