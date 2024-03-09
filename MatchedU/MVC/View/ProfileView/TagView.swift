//
//  TagView.swift
//  EventApp
//
//  Created by Ahmadreza on 10/15/21.
//  Copyright © 2021 Alexani. All rights reserved.
//

import SwiftUI
import SwiftyJSON


struct TagView: View {
    @Binding var tags: [TagViewItem]
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight) // << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
        .task {
            print(tags)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(tags , id: \.title) {  tag in
                item(for: tag.title, isSelected:tag.isSelected)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag.title == self.tags.last!.title {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag.title == self.tags.last!.title {
                            height = 0 // last item
                        }
                        return result
                    }).onTapGesture {
                       // tag.isSelected.toggle()
                        UserApiCall().addNewInterest(interest: tag.title) { _response, isSuccess in
                            if isSuccess{
                                //tag.is_interest = tag.is_interest == "1" ? "0" : "1"
                            }else{
                                print("some bad happned!!! ")
                            }
                        }
                    }
            }
        }.background(viewHeightReader($totalHeight))
        
        
        func addNewInterest(tag : String){
            UserApiCall().addNewInterest(interest: tag) { _response, isSuccess in
                if isSuccess{
                    
                }else{
                    print("some bad happned!!! ")
                }
            }
        }
        
    }

    private func item(for text: String, isSelected: Bool) -> some View {
        Text(text)
            .foregroundColor(isSelected ? Color.black : Color.black)
            .padding()
            .lineLimit(1)
            .background(isSelected ? Color.primary_color : Color.white)
            .frame(height: 36)
            .cornerRadius(18)
            .overlay(Capsule().stroke(isSelected ? .white : Color.inactive_border, lineWidth: 1))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
