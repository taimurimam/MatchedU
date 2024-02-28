//
//  MatchedUApp.swift
//  MatchedU
//
//  Created by Taimur imam on 13/02/24.
//

import SwiftUI

@main
struct MatchedUApp: App { 
    var body: some Scene {
        WindowGroup {
            NavigationView{
                if loggedinUser.id.count > 0{
                //    FeedList()
                    Tabbar(logedinUser: LogedInUser())
                }else{
                    LoginView()
                }
            }
        }
    }
}
