//
//  ViewRouter.swift
//  CustomTabBar
//
//  Created by Gustavo Soares on 17/04/22.
//

import Foundation
import SwiftUI

enum Page {
    case feed
    case search
    case notification
    case profile

}

final class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .feed
    @Published var hideTabBar: Bool = false

    private (set) var tabs: [TabBarIconViewModel] = []
    private let iconWidth: CGFloat = 24.0
    private let iconHeight: CGFloat = 24.0

    init() {
        createTabs()
    }

    private func createTabs() {
        tabs = [
            TabBarIconViewModel(assignedPage: .feed,
                                width: iconWidth,
                                height: iconHeight,
                                iconName: "home_inactive", iconName_active: "home_active",
                                tabName: currentPage == .feed ? "Feed" : "dd"),
            
            TabBarIconViewModel(assignedPage: .search,
                                width: iconWidth,
                                height: iconHeight,
                                iconName: "search-inactive", iconName_active: "search-active",
                                tabName: "Search"),

            
            TabBarIconViewModel(assignedPage: .notification,
                                width: iconWidth,
                                height: iconHeight,
                                iconName: "notification_inactive", iconName_active: "notification_active",
                                tabName: "Notification") ,
            
            TabBarIconViewModel(assignedPage: .profile,
                                width: iconWidth,
                                height: iconHeight,
                                iconName: "user_inactive", iconName_active: "user_active",
                                tabName: "Profile")
        ]
    }
}
