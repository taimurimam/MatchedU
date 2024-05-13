
//  BackgroundView.swift
//  THE WiLL
//  Created by Taimur imam on 04/09/23.

import SwiftUI

enum BackGroundHeader : Int{
    case blue = 0
    case gray
}

struct BackgroundView: View {
    var type = BackGroundHeader.blue
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.app_white, .background_gradient_top]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
