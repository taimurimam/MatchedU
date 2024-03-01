//
//  Notification.swift
//  MatchedU
//
//  Created by Taimur imam on 28/02/24.
//

import Foundation
import SwiftyJSON

struct Notification_model{
    var sender_name : String
    var sender_user_id: String
    var img_sublink: String
    var time: String
    var comment : String
    var notificaitonCategory : String
    var collage : String
    var graguation_year : String
    var id : String
    
    var icon : String{
        return "love_notification"
    }

    var notificationType : Notification_Type{
        if comment  == "like"{
            return .likestory
        }else
        if comment  == "ConectionRequest"{
            return .connection_request
        }else{
            return .profile_updated
        }
    }
    
    var profile_img : String{
        return mediaBaseUrl + img_sublink
    }
    
    init(from json: JSON)
    {
        self.sender_user_id = json["sender_id"].stringValue
        self.sender_name = json["sender_name"].stringValue
        self.img_sublink = json["sender_image"].stringValue
        self.time = json["created_at"].stringValue
        self.notificaitonCategory = json["notificaitonCategory"].stringValue
        self.comment = json["comment"].stringValue
        self.collage = json["qualification"].stringValue
        self.graguation_year = json["qualification_year"].stringValue
        self.id = json["id"].stringValue
    }
    
}
