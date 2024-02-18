//
//  HomeView.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                HeaderView( title: "Home", hideBackBtn: true)
            }
        }
    }
}

#Preview {
    HomeView()
}
