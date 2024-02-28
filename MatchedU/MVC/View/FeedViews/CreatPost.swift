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
            Color.off_white
                .ignoresSafeArea()
            VStack{
                ZStack(alignment: . trailing){
                    HeaderView(title:"Creat Post" , isDownBackBtn: true)
                    Button{
                        if isPostButtonActive{
                            createPost()
                        }
                    }label: {
                        Post_Button(title: "Post")
                            .padding(.horizontal)
                    }
                }
                VStack(spacing: 10){
                    postInputText(text: $text)
                    if selectedImage == nil{ // Image icon
                        Image(systemName: "photo.artframe")
                            .foregroundColor(.primary_color)
                            .font(.appFont(type: .Regular, size: 104))
                            .frame(maxWidth: UIScreen.main.bounds.width  - 40.0)
                            .frame(height: 180)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.leading , 50)
                            .onTapGesture {
                                showImagePickerOptions.toggle()
                            }
                    }else{ // Seleceted image
                        ZStack(alignment:.topTrailing){
                            Image(uiImage: selectedImage ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: UIScreen.main.bounds.width  - 40.0)
                                .frame(height: 180)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .padding(.leading , 50)
                                .clipped()
                                .onTapGesture {
                                    showImagePickerOptions.toggle()
                                }
                            Image(systemName: "xmark.circle")
                                .btnActionStyle()
                                .foregroundStyle(Color.app_black)
                                .padding(.trailing , 5)
                                .onTapGesture {
                                    selectedImage = nil
                                }
                        }
                    }
                    
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
            
            .gesture(DragGesture().onChanged({ _ in
                hideKeyboard()
            }))
        }
    }
    
    //MARK - All function will be go here
    
    func createPost(){
        hideKeyboard()

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


struct postInputText : View {
    @Binding var text : String
    @FocusState private var isEditing : Bool
    
    var body: some View {
        HStack(alignment:.top){
            ProfileImage(url: loggedinUser.profile_image , width: 30)
                .padding(.top)
            ZStack(alignment:.topLeading){
                TextEditor(text: $text)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(Color.app_white)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .font(.app_body_Font(type: .Regular, size: 18))
                    .lineSpacing(6) 
                    .scrollContentBackground(.hidden)
                    .focused($isEditing)
                
                if text.isEmpty{
                    Text("whats going on......")
                        .padding()
                        .foregroundColor(.black.opacity(0.7))
                        .font(.app_body_Font(type: .Regular, size: 18))
                }
            }
        }
        .onAppear(){
            isEditing = true
        }
    }
}
