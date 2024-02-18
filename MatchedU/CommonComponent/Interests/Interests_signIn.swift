//
//  Interests_signIn.swift
//  MatchedU
//
//  Created by Taimur imam on 14/02/24.
//

import SwiftUI

struct Interests_signIn: View {
    var tags_name = ["Hello" , "taimur"]
    var body: some View {
        VStack{
            HStack{
                Text("Interest")
                    .foregroundStyle(Color.black)
                    .font(.appFont(type: .Bold, size: 17))
                Spacer()
                Button{
                    
                }label: {
                    Text("Add New")
                        .padding(12)
                        .foregroundColor(.app_white)
                        .frame(height: 38)
                        .background(Color.primary_color)
                        .cornerRadius(19)
                    
                }
            }
            .padding(.horizontal)
        }
        .onAppear(){
            getAllTags()
        }
    }
    
    
    //get all tags
    func getAllTags(){
    }
}

#Preview {
    Interests_signIn()
}
