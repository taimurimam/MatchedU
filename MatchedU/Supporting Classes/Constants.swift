//
//  Constants.swift
//
//  Copyright © 2023 Sk Azad. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var screenWidth = UIScreen.main.bounds.size.width
var screenHeight = UIScreen.main.bounds.size.height

//var currentUserM: UserModel {
//    if AppController.shared.userM.id > 0
//    {
////        print("Current user role id:", AppController.shared.userM.roleId)
//        return AppController.shared.userM
//    }
//    else {
////        print("stored user not found:", AppController.shared.userM.roleId)
//        return UserModel(from: JSON())
//    }
//}
//var mediaBaseUrl: String {
//    UserDefaults.getString(forKey: .mediaUrl)
//}


let strErrorCodeMsg = "Error code"
let strFailedToLoad = "Please check your network connection and try again later."
let strPleaseWait = "Please wait..."
let strCancel = "Cancel"
let failedToLoad = "Please check your network connection and try again later."

let isProviderApp = (Bundle.main.bundleIdentifier ?? "") != "azad.sap.Aikina"
