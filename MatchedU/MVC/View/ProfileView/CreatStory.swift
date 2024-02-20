//
//  CreatStory.swift
//  MatchedU
//
//  Created by Taimur imam on 16/02/24.
//

import SwiftUI
import AlertToast

struct CreatStory: View {
    var isEditable = false
    
    @State private var selectedImage: UIImage?
    let img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.mHdqFUfBVtiT5ZAYKodjzQHaF9%26pid%3DApi&f=1&ipt=a39214d0c5033ce7d8edf6bc9a653230e64e8190a8d0cb6faa452d74c8aba115&ipo=images"
    @State var showImagePickerOptions = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var toastMessage = ""
    @State private var isToast = false
    @State private var isToast_Success = false

    @State private var storyTitle = ""
    
    var body: some View {
        ZStack{
            Color.app_white
                .ignoresSafeArea()
            VStack(alignment:.center){
                HeaderView(title: "Creat Story")
                VStack(alignment: .center , spacing: 20){
                    InputField(text: $storyTitle, placeholder: "Story Title")
                        .padding(.top , 20)
                    ZStack(alignment:.center){
                        if (selectedImage != nil ){ // if user select image then image need to display
                            Image(uiImage: selectedImage ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: CGFloat(Int(UIScreen.main.bounds.width)) - 50 , height: 240)
                                .cornerRadius(12)
                                .clipped()
                                .padding(.bottom)
                        }
                        VStack{
                            PlusButton()
                                .onTapGesture {
                                    selectImage()
                            }
                        }
                    }
                    .frame(height: 240)
                }
                .frame( height: 350)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .app_black.opacity(0.1), radius: 10 , x: 4 , y: 8)
                .padding(.horizontal)
                
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
                
                Button{
                    addStoryButtonPressed()
                }label: {
                    Large_Blue_Button(title: "Add Story")
                        .padding(.horizontal)
                }
                .padding(.top , 30)
                
                // Show Image Picker
                .sheet(isPresented: $showImagePicker) {
                    ProfileImagePicker( image: $selectedImage , isShown: $showImagePicker, isProfileCropView: $showImagePicker , photo_for: .cover , sourceType: sourceType)
                        .onDisappear{
                        }
                }
                Spacer()
            }
        .navigationBarHidden(true)
        .toast(isPresenting: $isToast){
            AlertToast(type: .regular, title: toastMessage)
            }
        .toast(isPresenting: $isToast_Success){
            AlertToast(type: .regular, title: toastMessage)
            }
        }
        Spacer()
    }
    
    func selectImage(){
        showImagePickerOptions.toggle()
    }
    
    func addStoryButtonPressed(){
        if storyTitle.isEmpty{
            toastMessage = "Please add title"
            isToast.toggle()
        }else
        if selectedImage == nil{
            toastMessage = "Please add image"
            isToast.toggle() 
        }else{
            creatStory()
        }
    }
    
    
    func creatStory(){
        StoryApiCall().creatNewStory(storyTitle: storyTitle, img: selectedImage!) { _response in
            if _response.isSuccess{
                toastMessage = "Your story has been created."
                isToast_Success.toggle()
            }else{
                
            }
        }
    }
    
}

#Preview {
    CreatStory()
}
