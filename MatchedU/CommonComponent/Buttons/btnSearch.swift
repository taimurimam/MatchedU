//
//  btnSearch.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import SwiftUI

struct btnSearch: View {
    var body: some View {
        NavigationLink(destination:SeachView()){
            Image("search")
                .btnActionStyle()
        }
    }
}

#Preview {
    btnSearch()
}
