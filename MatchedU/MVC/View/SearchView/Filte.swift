//
//  SwiftUIView.swift
//  MatchedU
//
//  Created by Taimur imam on 27/02/24.
//

import SwiftUI

enum Gender : Int{
    case Male = 0
    case Female
    case notSelected
    
}

struct FilterView: View {
    
    @Binding var isSchoolSelected : Bool
    @Binding var isFilter : Bool
    @Binding var collageName : String
    @Binding var gender : Gender
    var collage : String{
        return collageName.isEmpty ? "School / College" : collageName
    }
    
    let applyFilter: () -> Void
    
    var body: some View {
        ZStack(alignment:.bottom){
            Color.filterBackGround
                .ignoresSafeArea()
            VStack(alignment: .leading , spacing: 5){
                HStack{
                    Spacer()
                    Color.inactive_border
                        .frame(width: 36 , height: 5)
                        .clipShape(Capsule())
                    Spacer()
                }
                .padding(.top , 2)
                HStack{
                    Text("Filters")
                        .foregroundStyle(Color.app_black)
                        .font(.appFont(type: .Bold, size: 25))
                    Spacer()
                    Button{
                        clearAllFilters()
                    }label: {
                        Text("X Clear all")
                            .font(.app_body_Font(type: .Regular, size: 15))
                            .foregroundStyle(Color.app_black)
                            .padding()
                    }
                }
                .padding(.horizontal)
                Spacer()
                Text("Filter out the students  on the bases of college, interests and gender")
                    .font(.app_body_Font(type: .Regular, size: 17))
                    .foregroundStyle(Color.text_secondary_color)
                    .padding(.horizontal)
                
                // Gender Selection
                VStack(alignment: .leading, content: {
                    Text("Gender")
                        .font(.app_body_Font(type: .Regular , size: 18))
                    HStack(spacing: 20){
                        HStack(spacing:15){
                            Image(gender == .Male ? "male_white" : "male_black")
                            Text("Male")
                        }
                        .genderBtnStyle(isSelected: gender == .Male ? true : false)
                        .onTapGesture {
                            withAnimation{ gender = .Male}
                        }
                        HStack(spacing:15){
                            Image(gender == .Female ? "female_white" : "female_black")
                            Text("Female")
                        }
                        .genderBtnStyle(isSelected: gender == .Female ? true : false)
                        .onTapGesture {
                            withAnimation{gender = .Female}
                        }
                    }
                })
                .padding(.top , 15)
                .padding(.horizontal)
                
                // School Selection
                Button{
                    isSchoolSelected.toggle()
                }label: {
                    VStack{
                        HStack{
                            Text(collage)
                            Spacer()
                            Image("teacher")
                        }
                        Color.app_black
                            .frame(height: 0.75)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top , 30)
                    
                    .padding(.horizontal)
                }
                
                //Interests
                
                VStack(alignment: .leading, content: {
                    Text("Interests")
                        .font(.app_body_Font(type: .Regular , size: 18))
                    
                })
                .padding(.top , 15)
                .padding(.bottom , 20)
                .padding(.horizontal)
                Large_Blue_Button(title: "Apply Filters")
                    .padding(.bottom , 30)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation{
                            applyFilter()
                            isFilter.toggle()
                        }
                    }
            }
            .frame(height: 450)
            .background(Color.app_white)
            .cornerRadius(12)
            .foregroundStyle(Color.app_black)
            .padding(.horizontal , 8)
        }
        .background(Color.clear)
    }
    
    //MARK: - Clear all functions
    
    func clearAllFilters(){
        collageName = ""
        gender = .notSelected
       // isFilter.toggle()
       // applyFilter()
    }
    
}

#Preview {
    FilterView(isSchoolSelected: .constant(false), isFilter: .constant(false), collageName: .constant(""), gender: .constant(.notSelected), applyFilter: {})
}
