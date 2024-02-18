//
//  NoticeActionButton.swift
//  THE WiLL
//
//  Created by Taimur imam on 30/10/23.
//

import SwiftUI
 
enum NoticeActionBtnType : Int{
    case normal = 0
    case reject
}

struct NoticeActionButton: View {
    var isPending = false
    var title = ""
    var btnType = NoticeActionBtnType.normal 
    var body: some View {
        Text(title)
            .padding(.horizontal)
            .padding(10)
            .background(btnType == .normal ?  Color.app_blue.opacity(isPending ? 0.55 : 1.0) : Color.red.opacity(0.87))
            .cornerRadius(8)
            .foregroundColor(.white)
            .font(.appFont(type: .Regular, size: 15))
            .shadow(color: .black.opacity(0.1), radius: 5)
    }
}

#Preview {
    NoticeActionButton()
}
