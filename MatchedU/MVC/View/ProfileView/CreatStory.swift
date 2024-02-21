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
    var isPostButtonActive :Bool{
        if !storyTitle.isEmpty || selectedImage != nil
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
                    HeaderView(title:"Creat Post")
                    Button{
                        if isPostButtonActive{
                            addStoryButtonPressed()
                        }
                    }label: {
                        Post_Button(title: "Add Story")
                            .padding(.horizontal)
                    }
                }
                VStack(spacing: 10){
                    postInputText(text: $storyTitle)
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
            .toast(isPresenting: $isToast_Success){
                AlertToast(type: .regular, title: toastMessage)
                }
            }
            .gesture(DragGesture().onChanged({ _ in
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }))
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
                toastMessage = _response.strResMsg 
                isToast_Success.toggle()

            }
        }
    }
    
}

#Preview {
    CreatStory()
}
