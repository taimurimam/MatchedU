
//  InputField.swift
//  THE WiLL
//  Created by Taimur imam on 04/09/23.

import SwiftUI

enum InputFiled_Type : Int{
    case text = 0
    case email
    case password
    case phone_no
    case date_of_birth
    case search_Email
}

struct InputField: View {
    @State var isCountryPicker =  false
    @State var isHideText = false
    @Binding var text : String
    var isBorder = true
    var inputFieldType = InputFiled_Type.text
    var placeholder : String
    var color : Color{
        return text.isEmpty ? Color.placeholder : Color.app_blue
    }
    @State  var country  = "+1"
    var color_border : Color{
        return text.isEmpty ? Color.inactive_border : Color.app_black
    }
    var keyBoardType : UIKeyboardType{
        if inputFieldType == .phone_no{
            return .numberPad
        }else
        if inputFieldType == .email || inputFieldType == .search_Email{
            return .emailAddress
        }
        else{
            return .default
        }
    }

    var body: some View {
        ZStack(alignment: .bottomLeading  ){
            if isBorder{
                VStack{
                }.inputFieldStyle()
            }
            HStack{
                if inputFieldType == .phone_no{
                    Button(country){
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
                            .font(.app_body_Font(type: .Regular, size: 17))
                    }else{
                        if inputFieldType != .search_Email{
                            Text(placeholder)
                                .foregroundColor(color)
                                .padding(.horizontal)
                                .background(Color.clear).offset(x :  0 ,y: -29)
                                .font(.app_body_Font(type: .Regular, size: 14))
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
                    Image(isHideText ? "eye" : "eye-close")
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
            Color.placeholder
                .frame(maxWidth: .infinity , maxHeight: 0.75 )
                .padding(.horizontal)
                .offset(y:-5)
        }
        
        .sheet(isPresented: $isCountryPicker){
            CountryPickerView(  locationPickerType: .country, country: $country, showCountryPicker: $isCountryPicker)
        }
        
    }
    

    
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
