//
//  InputMobileNumber.swift
//  THE WiLL
//
//  Created by Taimur imam on 02/11/23.
//

import SwiftUI

struct InputMobileNumber: View {
    @State var isCountryPicker =  false
    @State var isHideText = false
    @Binding var text : String
    var isBorder = true
    var inputFieldType = InputFiled_Type.phone_no
    var placeholder : String
    var color : Color{
        return text.isEmpty ? Color.placeholder : Color.app_blue
    }
    @Binding  var country_code : String
    var color_border : Color{
        return text.isEmpty ? Color.inactive_border : Color.app_blue
    }

    var keyBoardType : UIKeyboardType{
        if inputFieldType == .phone_no{
            return .numberPad
        }else
        if inputFieldType == .email || inputFieldType == .search_Email{
            return .emailAddress
        }
        else
        {
            return .default
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading ){
            if isBorder{
                VStack{
                }.inputFieldStyle()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(color_border, lineWidth: 1.0)
                    )
            }
            HStack{
                if inputFieldType == .phone_no{
                    Button(country_code.isEmpty ? "+1" : country_code){
                        isCountryPicker.toggle()
                    }
                    .padding(.leading)
                    .padding(.vertical)
                    .foregroundColor(.black)
                }
                ZStack(alignment: .leading){
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.placeholder)
                            .padding(.horizontal)
                            .allowsTightening(false)
                    }else{
                        if inputFieldType != .search_Email{
                            Text(placeholder)
                                .foregroundColor(color)
                                .padding(.horizontal)
                            .background(Color.white).offset(x :  10 ,y: -25)
                        }
                    }
                    if isHideText{
                        SecureField("", text: $text)
                            .keyboardType(.default)
                            .inputFieldStyle()
                            .keyboardType(.default)

                    }else{
                        TextField("", text: $text)
                            .keyboardType(.default)
                            .inputFieldStyle()
                            .keyboardType(keyBoardType)
                            
                    }
                }
                if inputFieldType == .password{
                    Image("eye-alt")
                        .padding()
                        .onTapGesture {
                            isHideText.toggle()
                        }
                }
                if inputFieldType == .date_of_birth{
                    Image("calendar")
                        .padding()
                }
            }
        }
        
        .sheet(isPresented: $isCountryPicker){
            CountryPickerView(  locationPickerType: .country, country: $country_code, showCountryPicker: $isCountryPicker)
        }
    }
}

