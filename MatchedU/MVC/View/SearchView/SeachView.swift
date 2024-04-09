//
//  SeachView.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import SwiftUI
import AlertToast
import PopupView
import SwiftyJSON

struct SeachView: View {
    @State private var toastMessage = ""
    @State private var isToastMessage = false
    @State private var users = [UserModel]()
    @State var isFilterOpen = false
    @State var isCollageSelectionOpen = false
    @State var gender = Gender.notSelected
    @State var collageName = ""
    var user_id  = ""
    var isFromConection = false
    @State private var isLoading = false
    @State private var page = 1
    @State private var userIndex = 0
    var user : UserModel{
        if users.isEmpty{
            return UserModel(from: JSON())
        }else{
            if self.user.id == users.last?.id{
                return users.last ?? UserModel(from: JSON())
            }else{
                return users[userIndex]
            }
        }
    }
    
    var noOfFilter : Int{
        var count = 0
        if !collageName.isEmpty{
            count += 1
        }
        if gender != .notSelected{
            count += 1
        }
        return count
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.app_white, .background_gradient_top]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack{
                if isFromConection{
                    HeaderView(title: "Conections")
                }else{
                    HStack {
                        VStack(alignment:.leading , spacing: 5){
                            Text("Let’s Explore")
                                .font(.appFont(type: .Regular, size: 25))
                            Text("Find the students based on your interests")
                                .font(.app_body_Font(type: .Regular, size: 15))
                        }
                        .padding(.leading)
                        .foregroundStyle(Color.black)
                        Button{
                            withAnimation{
                                isFilterOpen.toggle()
                            }
                        }label: {
                            ZStack(alignment:.top){
                                Image("filters")
                                if noOfFilter > 0{
                                    Text("\(noOfFilter)")
                                        .frame(width: 25 , height: 25)
                                        .background(Color.primary_color)
                                        .clipShape(Circle())
                                        .foregroundStyle(Color.app_white)
                                        .offset(x: 15 , y: 15)
                                }
                            }
                        }
                    }
                }
            
                ScrollView{
                    if !isFromConection { // explore list
                        if !users.isEmpty{
                            if users.count > userIndex{
                                SearchProfileCell(userIndex: $userIndex, user: $users[userIndex])
                                    .onAppear(){
                                        if userIndex % 8 == 0 && !isLoading {
                                            isLoading = true
                                            getUsers()
                                        }
                                    }
                            }
                        }
                        Spacer(minLength: 0.01)
                    }else{ // Conections List
                        LazyVStack(spacing: 30){
                            ForEach(users.indices, id: \.self) { index in
                                NavigationLink(destination: ProfileView(user_id: users[index].id)){
                                    SearchProfileCell(userIndex: $userIndex, user: $users[index] , isFromConection: true)
//                                        .onAppear(){
//                                            if  users[index].id == self.users.last?.id && !isLoading {
//                                                isLoading = true
//                                                getUsers()
//                                            }
//                                        }
                                }
                            }
                            if isLoading{
                                Text("Loading... ")
                            }
                        }
                    }
                    
                }
                .navigationBarHidden(true)
                .task {
                    if isFromConection{// If conection
                        conectionList()
                    }else{
                        if users.isEmpty{ getUsers() }
                    }
                }
                .toast(isPresenting: $isToastMessage){
                    AlertToast(type: .regular, title: toastMessage)
                }
                
                .fullScreenCover(isPresented: $isCollageSelectionOpen, content: {
                    CollageSelectionView( selectedCollage: $collageName)
                })
                
                .popup(isPresented: $isFilterOpen) {
                    FilterView(isSchoolSelected: $isCollageSelectionOpen, isFilter: $isFilterOpen, collageName: $collageName, gender: $gender, applyFilter: {
                        getUsers()
                    })
                } customize: {
                    $0
                        .type (.floater())
                        .dragToDismiss(true)
                        .position(.bottom)
                }
            }
        }
        
    }
        //MARK: - All Functions are here.....
        
        func getUsers(){
            if !isLoading{
                showHud()
            }
            let params = [
                "user_id" : loggedinUser.id ,
                "qualification" : collageName,
                "page" : "\(page)"
            ]
            UserApiCall().getUserList(params: params) { _response in
                if _response.isSuccess{
                    let newProfiles = _response.completeJsonResp["data"]["user_list"].arrayValue.map { UserModel(from: $0 )}
                    if newProfiles.count>0{page += 1}
                    self.users += newProfiles
                }else{
                    toastMessage = _response.strResMsg
                    isToastMessage.toggle()
                }
                isLoading = false
            }
        }
        
        func conectionList(){
            if self.users.isEmpty{ 
                showHud()
                notificationApiCall().conectionList(user_id:user_id.isEmpty ? loggedinUser.id : user_id){ _response in
                    hideHud()
                    if _response.isSuccess{
                        let newProfiles =  _response.completeJsonResp["data"]["connects_list"].arrayValue.map { UserModel(from: $0 )}
                        if newProfiles.count>0{page += 1}
                        self.users += newProfiles
                    }else{
                        toastMessage = _response.strResMsg
                        isToastMessage.toggle()
                    }
                }
            }
        }
}

#Preview {
    SeachView()
}
