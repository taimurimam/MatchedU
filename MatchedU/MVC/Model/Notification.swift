//
//  Notification.swift
//  MatchedU
//  Created by Taimur imam on 28/02/24.

import Foundation
import SwiftyJSON
 
enum Conection_status : Int {
    case conceted = 0
    case requestPending
    case rejected
    case none
}

struct Notification_model { 
    var sender_name : String
    var sender_user_id: String
    var img_sublink: String
    var time: String
    var comment : String
    var notificaitonCategory : String
    var collage : String
    var graguation_year : String
    var id : String
    var conection_status_info : String
    var feed_id : String
    
    var conection_status : Conection_status{
        if comment == "Accept your connections"{
            return .conceted
        }else
        if conection_status_info == "1"
        {
            return .conceted
        }else
        if conection_status_info == "0" {
            return .requestPending
        }else
        if conection_status_info == "2"{
            return .rejected
        }else{
            return .requestPending
        }
    }
    
    var icon : String{
        if notificationType == .likestory{
            return "love_notification"
        }else{
            return "notification_nonection_request"
        }
    }

    var notificationType : Notification_Type{
        if comment == "Like your feed"{
            return .likestory
        }else
        if comment  == "Accept your connections"{
            return .conection_requestAccepted
        }else
        if comment  == "Want to connect with you"{
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
        self.conection_status_info = json["connect_status"].stringValue
        self.feed_id = json["feed_id"].stringValue
    }
}
