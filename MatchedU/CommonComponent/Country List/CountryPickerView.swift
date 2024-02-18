//
//  CountryPickerView.swift
//  Aikina
//
//  Created by Sk Azad on 07/06/23.
//

import SwiftUI
enum LocationPickerType : Int
{
    case country = 0
    case region
}

struct CountryPickerView: View {
    
    @State private var strSearch = ""
    var locationPickerType = LocationPickerType.region 
    @State var arrCountries = CountryModel.getAllCountries()
    @Binding var country : String
    @Binding var showCountryPicker: Bool
    var title :String{
        return locationPickerType == .region ? "Region" : "Country"
    }
    
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                HStack{
                    Cross_blue_btn()
                        .padding(5)
                    Text(title)
                        .font(.appFont(type: .Regular, size: 24))
                        .foregroundColor(.black)
                    Spacer()
                }.padding()
                if locationPickerType == .country{
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 5) {
                            ForEach( arrCountries , id: \.self) { model in
                                HStack(spacing: 10) {
                                    Image(uiImage: model.flag ?? UIImage())
                                        .frame(width: 30, height: 30)
                                    Text(model.name)
                                    Text(model.phoneCode)
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .onTapGesture {
                                    country = model.phoneCode
                                    showCountryPicker = false
                                }
                            }
                        }.padding(.horizontal)
                    }
                }
                if locationPickerType == .region{
                    ScrollView(showsIndicators: false) {
                        LazyVStack(alignment: .leading){
                            ForEach(0...100 , id: \.self) { count in
                                HStack{
                                    Text("Region \(count)")
                                        .foregroundColor(.black)
                                        .font(.appFont(type: .Regular, size: 18))
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    showCountryPicker = false
                                    country = "Region \(count)"
                                 }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(  country: .constant(""), showCountryPicker: .constant(true))
    }
}
