//
//  TimerText.swift
//  MatchedU
//
//  Created by Taimur imam on 09/03/24.
//

import SwiftUI

struct TimerText : View {
    var timeString = ""
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State var time = ""
    var body: some View {
        HStack{
            Image("clock")
            Text(time)
                .foregroundStyle(Color.text_secondary_color)
                .font(.app_body_Font(type: .Regular, size: 14))
                .offset(x:-3)
                .onReceive(timer) { _ in
                    time = Utilities().calculateTimeDifference(time: timeString)
                }
                .onAppear(){
                    time = Utilities().calculateTimeDifference(time: timeString)
                }
        }
    }
}
