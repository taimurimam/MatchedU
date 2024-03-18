//
//  EditProfie.swift
//  MatchedU
//  Created by Taimur imam on 16/02/24.
 

enum Photo_Select_for : Int {
    case profile = 0
    case cover
}
import SwiftUI
import AlertToast
import SwiftyJSON

struct EditProfie: View {
    
    @State var Name = loggedinUser.name
    @State var bio = loggedinUser.bio
    @State var dateOfBirth = loggedinUser.dob
    @State var school_collage = loggedinUser.collage
    @State var graduation_year = loggedinUser.graduation_year
    @State var email = loggedinUser.email
    @State var imageSelectionFor = Photo_Select_for.profile
    @State var linkdin_url = loggedinUser.linkdin_url
    @Binding var userModel : UserModel
    @State private var profile_photo:UIImage?
    @State private var cover_photo:UIImage?
    @State var showImagePickerOptions = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var showImageCropper: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isProfileEditedAlert = false
    @State private var isCollageList = false
    @State private var toastMessage = ""
    @State private var isToastMessage = false
    
    var body: some View {
        ZStack{
            Color.app_white
                .ignoresSafeArea()
            VStack{
                ZStackLayout(alignment: .trailing){
                    HeaderView(title: "Edit Profile")
                    Button{
                        UpdateButtonPressed()
                    }label: {
                        Post_Button(title: "Save")
                            .padding(.horizontal)
                    }
                }
                KeyboardDismissingScrollView{
                ZStack(alignment:.bottomLeading){
                    // Cover Photo
                    ZStack(alignment:.bottomTrailing){
                        if (cover_photo != nil ){ // if user select image then image need to display
                           Image(uiImage: cover_photo ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 240)
                                .clipped()
                        }else{
                            ProfileCoverPhoto(url: userModel.cover_image)
                                .shadow(color: .black.opacity(0.1), radius: 10 , x: 4 , y: 8)
                        }
                        Button{
                            imageSelectionTapped(imageFor: .cover)
                        }label: {
                            Image("edit")
                                .frame(width: 40 , height: 40)
                                .background(.black.opacity(0.87))
                                .clipShape(Circle())
                                .padding()
                        }
                    }
                    
                    // Profile image
                    
                    ZStack{
                        if (profile_photo != nil ){ // if user select image then image need to display
                           Image(uiImage: profile_photo ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.3), radius: 10 , x: 4 , y: 8)
                                .overlay(
                                    Circle().stroke(.white, lineWidth: 3.0)
                                )
                        }else{
                            ProfileImage(url: userModel.profile_image , width: 100, leading_padding: 0)
                                .shadow(color: .black.opacity(0.3), radius: 10 , x: 4 , y: 8)
                                .overlay(
                                    Circle().stroke(.white, lineWidth: 3.0)
                                )
                        }
                        Color.black.opacity(0.3)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Image("camera")
                    }
                    .padding(.leading , 20)
                    .offset(y: 25)
                    .onTapGesture {
                        imageSelectionTapped(imageFor: .profile)
                    }
                }
                    
                
                    
                    VStack( alignment:.leading ,  spacing: 20){
                        Text("About me")
                            .padding(.leading)
                            .profileSectionTitleStyle()
                        InputTextEditor(text: $bio)
                    }
                    .padding(.top , 50)
                    
                    VStack( alignment:.leading ,  spacing: 20){
                        Text("Personal Information")
                            .padding(.leading)
                            .profileSectionTitleStyle()
                        InputField(text: $Name , inputFieldType: .text, placeholder: "Full Name")
                        InputField(text: $email , inputFieldType: .email, placeholder: "Email")
                            .allowsHitTesting(false) 
                        //  InputDate(birthDate: $dateOfBirth)
                        ZStack{
                            InputField(text: $school_collage , inputFieldType: .email, placeholder: "School/College")
                                .allowsTightening(false)
                            HStack{
                                Color.white.opacity(0.01)
                                    .onTapGesture {
                                        isCollageList.toggle()
                                    }
                            }
                        }
                        InputField(text: $graduation_year , inputFieldType: .email, placeholder: "Graduation year")
                        InputField(text: $linkdin_url , inputFieldType: .text, placeholder: "Linkdin Profile link")
                        ProfileStoryView( sendConectionRequest: {}, userModel: $userModel)
                    }
                    .padding(.top)
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
                
                // Show Image Picker
                .sheet(isPresented: $showImagePicker) {
                    ProfileImagePicker( image: imageSelectionFor == .profile ? $profile_photo : $cover_photo , isShown: $showImagePicker, isProfileCropView: $showImagePicker , photo_for: imageSelectionFor , sourceType: sourceType)
                        .onDisappear{
                            if imageSelectionFor  == .profile && profile_photo != nil{
                                showImageCropper.toggle()
                            }
                        }
                }
                
                //Crop image for profile picture.........
                
                .fullScreenCover(isPresented: $showImageCropper) {
                    SwiftyCropView(
                        imageToCrop: profile_photo!,
                        maskShape: .circle
                    ) { croppedImage in
                        profile_photo = croppedImage
                    }
                }
                
                .toast(isPresenting: $isToastMessage){
                    AlertToast(type: .regular, title: toastMessage)
                }

                
                .fullScreenCover(isPresented: $isCollageList, content: {
                    CollageSelectionView( selectedCollage: $school_collage)
                })

                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            if isProfileEditedAlert{
                customAlertUI(alerttype: .profileUpdated, message: "Your profile has been updated", title: "Updated", isHide: $isProfileEditedAlert)
            }
        }
        .task {
            Name = userModel.name
             bio = userModel.bio
            dateOfBirth = userModel.dob
            school_collage = userModel.collage
            graduation_year = userModel.graduation_year
            email = userModel.email
            linkdin_url = userModel.linkdin_url
        }
    }
    
    // All Functions Will be here.......
    
    func UpdateButtonPressed(){
        if !linkdin_url.isEmpty && !linkdin_url.isValidLinkDinLink{
            toastMessage = "You have entered wrong Linkedin url, Please provide valid one."
            isToastMessage.toggle()
        }else{
            editProfileApiCall()
        }
    }
    
    func imageSelectionTapped(imageFor : Photo_Select_for){
        self.imageSelectionFor = imageFor
        showImagePickerOptions.toggle()
    }
    
    // Call API to update all edited information....
    
    func editProfileApiCall(){
        hideKeyboard()

        let params = [
            "user_id" : loggedinUser.id,
            "linkedin_url" : linkdin_url,
            "name" : Name ,
            "gender" : "Male" ,
            "about_me" : bio ,
            "qualification_year" : graduation_year ,
            "tag" : ["cricket" , "footbal" , "politics"],
            "qualification" : school_collage,
            "dob" : loggedinUser.dob
        ] as [String : Any]
        var images = [UIImage]()
        var filename = [String]()
        if profile_photo != nil{
            images.append(profile_photo!)
            filename.append("image")
        }
        if cover_photo != nil{
            images.append(cover_photo!)
            filename.append("cover_image")
        }
        
        UserApiCall().editProfileAndprofileImage(params:params , images: images, imageFileName: filename) { _response, isSuccess in
            if isSuccess{
                print("Profile Updated")
                isProfileEditedAlert.toggle()
            }else{
                print(_response.strResMsg)
                toastMessage = _response.strResMsg
                isToastMessage.toggle()
            }
        }
    }
    
    
}

#Preview {
    EditProfie( userModel: .constant(UserModel(from: JSON())))
}
