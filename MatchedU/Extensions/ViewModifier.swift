//
//  ViewModifier.swift
//  THE WiLL
//  Created by Taimur imam on 04/09/23.

import SwiftUI

struct genderBtnModifier : ViewModifier{
    var isSelected = false
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal , 10)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.primary_color : Color.app_white)
            .clipShape(Capsule())
            .foregroundStyle(isSelected ?  Color.app_white : Color.app_black)
            .font(.app_body_Font(type: .Regular, size: 18))
            .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(isSelected ? Color.app_white :  Color.app_black, lineWidth: 1.5)
            )    }
}


struct inputFieldModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .foregroundColor(.app_black)
            .font(.appFont(type: .Regular, size: 17))
            .padding(.horizontal)
            .cornerRadius(28)
    }
}
struct iconButtonModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
        
            .frame(width: 40 , height: 40)
            .background(.white)
            .clipShape(Circle())
            .padding()
            .shadow( color: .black.opacity(0.1),  radius: 10 , x:4 , y: 8)
            .padding(.bottom)
    }
}

struct craetFeedButtonModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
        
            .frame(width: 60 , height: 60)
            .background(Color.primary_color)
            .clipShape(Circle())
            .padding()
            .padding(.bottom)
            .foregroundStyle(Color.app_white)
            .font(.appFont(type: .Bold, size: 27))
            .padding(.trailing , 5)
            .shadow( color: .black.opacity(0.7),  radius: 15 , x:8 , y: 12)

    }
}


struct profileSectionHeaderModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.app_body_Font(type: .Bold, size: 22))
            .foregroundStyle(Color.app_black)

    }
}



struct white_btn_modifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .cornerRadius(12)
            .foregroundColor(.app_blue)
            .frame(width: 250)
            .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.app_blue, lineWidth: 1.5)
            )
    }
}

struct done_btn_modifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(Color.app_blue)
            .frame(height: 52)
            .cornerRadius(12)
    }
}

struct login_btnModificer : ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .frame(height: 52)
            .background(Color.app_blue)
            .cornerRadius(8)
            .shadow(color: .button_shado, radius: 10 , x: 0.0 , y: 10.0)
     }
}

struct inputDescriptionFieldModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(height: 75)
            .frame(maxWidth: .infinity)
            .foregroundColor(.app_black)
            .font(.app_body_Font(type: .Regular, size: 18))
            .padding(.horizontal)
            .multilineTextAlignment(.leading)
    }
}



extension  View{
    //craetFeedButtonModifier
    
    func btnCreatPostStyle()->some View{
        modifier(craetFeedButtonModifier())
    }
    
    func genderBtnStyle(isSelected : Bool)->some View{
        modifier(genderBtnModifier(isSelected: isSelected))
    }


    func profileSectionTitleStyle()->some View{
        modifier(profileSectionHeaderModifier())
    }
    func btnActionStyle()->some View{
        modifier(iconButtonModifier())
    }

    

    func inputFieldStyle()->some View{
        modifier(inputFieldModifier())
    }
    
    func loginButtonStyle()->some View{
        modifier(login_btnModificer())
    }
    
    func inputDescriptionFieldStyle()->some View{
        modifier(inputDescriptionFieldModifier())
    }
    
    func white_btn_style()->some View{
        modifier(white_btn_modifier())
    }
    func done_btn_style()->some View{
        modifier(done_btn_modifier())
    }

    
    
    
}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
#endif

extension Notification.Name {
    static let message_upload_done = Notification.Name("videouploaddone")
}
