//
//  PlusButton.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.
//

import SwiftUI

struct PlusButton: View {

    var width = 60.0
    var fontSize = 34
    var body: some View {
        Image(systemName: "plus")
            .foregroundStyle(Color.white)
            .font(.appFont(type: .Bold, size: fontSize))
            .frame(width: width , height: width)
            .background(Color.primary_color)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.2), radius: 30 , x: 4 , y: 10)
    }
}

struct BtnCreatStory : View {
    var body: some View {
        NavigationLink(destination: CreatStory()) {
            PlusButton(width: 40 , fontSize: 23)
        }
    }
}

struct btnVisit : View {
    var link : String
    var body: some View {
        Button{
            openTheUrl() 
        }label: {
            Text("visit")
                .padding(.horizontal)
                .frame(height: 30)
                .background(Color.secondary_background)
                .clipShape(Capsule())
                .foregroundStyle(Color.app_white)
        }
    }
    
    func openTheUrl(){
        let url  = URL(string: link)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:])
        }
    }
    
}
