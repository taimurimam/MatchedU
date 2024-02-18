//
//  AppController.swift
//  Quickvite
//
//  Created by Sk Azad on 02/07/20.
//  Copyright © 2020 Sk Azad. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class AppController
{
    static let shared = AppController()
    
    private var _userM: UserModel // Private storage for the userM
    var isPad: Bool{
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }else{
            return  false
        }
    }

    var userM: UserModel {
        get {
            let json = UserDefaults.getJSON(forKey: .userDetails)
            print(json) 
            return UserModel(from: json)
        }
        set {
            _userM = newValue
        }
    }
    
    private init(){
        _userM = UserModel(from: JSON())
    }
}


var isiPad: Bool{
    AppController.shared.isPad
}

var loggedinUser: UserModel {
    AppController.shared.userM
}

