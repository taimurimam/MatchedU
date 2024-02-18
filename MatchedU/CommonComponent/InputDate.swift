//
//  InputDate.swift
//  THE WiLL
//
//  Created by Taimur imam on 07/09/23.
//

import SwiftUI

struct InputDate : View{
    @Binding  var birthDate : Date
    @State var calendarId: UUID = UUID()
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDate)
    }

    func getLastYear ()->Int{
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        return currentYear - 17
    }
    
    func dateRange() -> ClosedRange<Date> {
           let calendar = Calendar.current
           let startDateComponents = DateComponents(year: 1900)
           let endDateComponents = DateComponents(year: getLastYear() )
           let startDate = calendar.date(from: startDateComponents)!
           let endDate = calendar.date(from: endDateComponents)!
           return startDate...endDate
       }
    
    var body: some View{
        ZStack (alignment: .bottom){
            VStack{
                HStack{
                    Text("Date of Birth")
                        .foregroundColor(.placeholder)
                        .font(.appFont(type: .Regular, size: 16))
                        .padding(.leading)
                    Spacer()

                   DatePicker(selection: $birthDate , in: dateRange() , displayedComponents: .date) {
                    }
                    .foregroundColor(.primary_color)
                    .accentColor(.primary_color)
                    .inputFieldStyle()
                    .changeTextColor(.primary_color)
                    .font(.appFont(type: .Regular, size: 16))
                    .onChange(of: birthDate, perform: { _ in
                        calendarId = UUID()
                    })
                }
            }
            Color.placeholder
                .frame(maxWidth: .infinity , maxHeight: 1.0)
                .padding(.horizontal)
        }
    }
}

struct InputDate_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension View {
    @ViewBuilder func changeTextColor(_ color: Color) -> some View {
        if UITraitCollection.current.userInterfaceStyle == .light {
            self.colorInvert().colorMultiply(color)
        } else {
            self.colorMultiply(color)
        }
    }
}
