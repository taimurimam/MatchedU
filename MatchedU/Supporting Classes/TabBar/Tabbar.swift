//
//  Tabbar.swift
//  Football
//
//  Created by Taimur imam on 26/05/23.
//

import SwiftUI

struct Tabbar: View {
    @ObservedObject var logedinUser : LogedInUser
    @StateObject var viewRouter = ViewRouter()
    enum Constants {
        static let stackSpacing: CGFloat = 0.0
    }
    
    var body: some View {
        VStack(spacing: Constants.stackSpacing) {
            switch viewRouter.currentPage {
            case .feed:
                NavigationView{
                    FeedList()
                }
            case .search:
                NavigationView{
                    SeachView()
                }
            case .notification:
                NavigationView{
                    Notifications()
                }
            case .profile:
                NavigationView{
                    ProfileView()
                }
            }
            TabBarView(viewRouter: viewRouter)
                .navigationBarHidden(true)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar(logedinUser: LogedInUser())
    }
}
