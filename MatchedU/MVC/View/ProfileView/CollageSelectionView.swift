//
//  CollageSelectionView.swift
//  MatchedU
//
//  Created by Taimur imam on 21/02/24.
//

import SwiftUI

struct CollageSelectionView: View {
    
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCollage : String
    var filtertedCollage: [String] {
        if searchText.isEmpty {
            return arrCollages
        } else {
            return arrCollages.filter { contact in
                contact.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // Get Collage list from Plist
    var  arrCollages : [String] {
        guard let plistPath = Bundle.main.path(forResource: "CollageList", ofType: "plist"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: plistPath)) else {
                return []
        }
        do {
            if let array = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String] {
                print(array)
                return array
            } else {
            }
        } catch {
            print("Error deserializing plist: \(error)")
            return []
        }
        return []
    }
    // End of Plist collage retrive function
    
    var body: some View {
        ZStack{
            Color.off_white
                .ignoresSafeArea()
            VStack{
                HeaderView(title: "Select Collage", isDownBackBtn: true)
                ZStack(alignment:.trailing){
                    InputField(text: $searchText, placeholder: "Search Collage ...")
                    if !searchText.isEmpty{
                        Image(systemName: "xmark.circle")
                            .btnActionStyle()
                            .foregroundStyle(Color.primary_color)
                            .padding(.trailing , 5)
                            .onTapGesture {
                                searchText = ""
                            }
                    }
                }
                ScrollView{
                    LazyVStack(alignment:.center , spacing: 20){
                        ForEach(filtertedCollage , id: \.self){collage in
                            HStack{
                                Spacer()
                                Text(collage)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(.app_black)
                            .background(Color.white)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 14, y: 18)
                            .cornerRadius(12)
                            .onTapGesture {
                                selectedCollage = collage
                                dismiss()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top,20)
                Spacer()
            }
        }
    }
}

#Preview {
    CollageSelectionView( selectedCollage: .constant(""))
}
