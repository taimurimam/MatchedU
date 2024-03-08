//
//  Interests.swift
//  MatchedU
//  Created by Taimur imam on 07/03/24.


import SwiftUI

struct Interests: View {
    @State private var tags = [TagViewItem]()
    @State private var search_text = ""
    
    var filtertedCollage: [TagViewItem] {
        if search_text.isEmpty {
            return tags
        } else {
            return tags.filter { tag in
                tag.title.localizedCaseInsensitiveContains(search_text)
            }
        }
    }
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                HeaderView(title: "Interest")
                ZStack(alignment:.trailing){
                    InputField(text: $search_text, placeholder: "Search tag")
                    if !tags.isEmpty{
                        Button {
                            if !search_text.isEmpty{
                                addNewInterest()
                            }
                        } label: {
                            Text("ADD")
                                .padding(10)
                                .padding(.horizontal , 10)
                                .background(Color.primary_color)
                                .foregroundStyle(Color.white)
                                .cornerRadius(8)
                                .padding()
                                .font(.app_body_Font(type: .Regular, size: 17))
                        }
                    }else{
                        Button{ searchPressed() } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(search_text.isEmpty ? Color.inactive_border : Color.primary_color)
                                .font(.app_body_Font(type: .Regular, size: 27))
                                .padding()
                        }
                    }
                }
                .padding(.top , 5)
                TagView(tags: $tags)
                    .padding(.horizontal)
                Spacer()
            }
            .task {
                getInterests()
            }
            .navigationBarHidden(true)
        }
    }
    
    func addNewInterest(){
        UserApiCall().addNewInterest(interest: search_text) { _response, isSuccess in
            if isSuccess{
                
            }else{
                print("some bad happned!!! ")
            }
        }
    }
    
    func searchPressed(){
        
    }
    
    func getInterests(){
        UserApiCall().getAllInterest { _response, isSuccess in
            if isSuccess{
                self.tags = _response.completeJsonResp["data"].arrayValue.map { TagViewItem(from: $0 )}
            }else{
                print("Some Bad Happned")
            }
        }
    }
}

#Preview {
    Interests()
}
