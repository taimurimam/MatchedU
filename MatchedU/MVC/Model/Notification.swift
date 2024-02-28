//
//  Notification.swift
//  MatchedU
//
//  Created by Taimur imam on 28/02/24.
//

import Foundation
import SwiftyJSON

struct Notification_model{
    var name : String
    var user_id: String
    var img_sublink: String
    var time: String
    var notificaitonCategory : String
    
    var notificationType : Notification_Type{
        return .likestory
    }
    var profile_img : String{
        return mediaBaseUrl + img_sublink
    }
    
    init(from json: JSON)
    {
        self.user_id = json["user_id"].stringValue
        self.name = json["owner_name"].stringValue
        self.img_sublink = json["owner_image"].stringValue
        self.time = json["time"].stringValue
        self.notificaitonCategory = json["notificaitonCategory"].stringValue
    }
}
