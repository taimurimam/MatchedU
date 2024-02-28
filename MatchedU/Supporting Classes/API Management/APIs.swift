//
//  APIs.swift
//
//  Copyright © 2023 Sk Azad. All rights reserved.
//

import Foundation

var strBaseUrl: String {
    "https://smartappsplanet.com/matchedu/api/"
    
}
var mediaBaseUrl : String{
    "https://smartappsplanet.com/matchedu/"
}

var strPrivacyPolicy = "https://www.sample.com/privacypolicy"
func getUrl(_ strExtension: String) -> String
{
    "\(strBaseUrl)\(strExtension)"
}

struct UserAPIs {
    static let signup = getUrl("register")
    static let login = getUrl("login")
    static let profileDetails = getUrl("profile-details")
    static let profileEdit = getUrl("customer-profile-update")
    static let logOut = getUrl("logout")  //forgot-password-otp-verificationp
    static let forgetEmailOTPSend = getUrl("forgot-password-send-mail")
    static let verifyOTP = getUrl("forgot-password-otp-verification")
    static let changePassword = getUrl("password-change")
    static let interestList = getUrl("interest-list")
    static let addNewInterest = getUrl("add-interes")
    //add-customer-document
    static let userList = getUrl("all-user-list")
    //all-user-lis
}

struct StoryApi{
    static let deleteStory = getUrl("customer-document-delete")
    static let addStory = getUrl("add-customer-document")
    static let likeStory = getUrl("document-like")

}


struct FeedAPIs {
    static let addFeed = getUrl("add-feed")
    static let feedList = getUrl("feed-list")
    static let deleteFeed = getUrl("feed-delete")
    static let likeFeed = getUrl("feed-like")
    
}
