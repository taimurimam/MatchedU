//
//  SeachView.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import SwiftUI

struct SeachView: View {
    
    var body: some View {
        ZStack{
            Color.off_white
                .ignoresSafeArea()
            VStack{
                HeaderView(title: "Search")
                Spacer()
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SeachView()
}
