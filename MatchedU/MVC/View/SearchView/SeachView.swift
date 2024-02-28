//
//  SeachView.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import SwiftUI
import AlertToast

struct SeachView: View {
    @State private var toastMessage = ""
    @State private var isToastMessage = false 
    @State private var users = [UserModel]()
    @State var isFilterOpen = false
    @State var isCollageSelectionOpen = false
    @State var gender = Gender.notSelected
    @State var collageName = ""
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
            Color.off_white
                .ignoresSafeArea()
            VStack{
                ZStack(alignment: .trailing) {
                    HeaderView(title: "Search")
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
                ScrollView{
                    LazyVStack(spacing: 30){
                        ForEach(users , id: \.id) { user in
                            NavigationLink(destination: ProfileView(user_id: user.id)){
                                SearchProfileCell(user: user)
                            }
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                Spacer()
            }
            .navigationBarHidden(true)
            .task {
                if users.isEmpty{ getUsers() }
            }
            .toast(isPresenting: $isToastMessage){
                AlertToast(type: .regular, title: toastMessage)
            }
            
            .fullScreenCover(isPresented: $isCollageSelectionOpen, content: {
                CollageSelectionView( selectedCollage: $collageName)
            })
            if isFilterOpen{
                FilterView(isSchoolSelected: $isCollageSelectionOpen, isFilter: $isFilterOpen, collageName: $collageName, gender: $gender, applyFilter: {
                    getUsers()
                })
            }
        }
    }
    
    
    //MARK: - All Functions are here.....

    func getUsers(){
        let params = [
            "user_id" : loggedinUser.id ,
            "qualification" : collageName
        ]
        UserApiCall().getUserList(params: params) { _response in
            if _response.isSuccess{
                self.users = _response.completeJsonResp["data"]["user_list"].arrayValue.map { UserModel(from: $0 )}
            }else{
                toastMessage = _response.strResMsg
                isToastMessage.toggle()
            }
        }
    }
    //
    
}

#Preview {
    SeachView()
}
