//
//  Feed_Model.swift
//  WonderLive
//
//  Created by Taimur imam on 26/12/23.
//

import Foundation
import SwiftyJSON

struct Feed_UserModel{
    var name : String
    var user_id: String
    var img_sublink: String
    var profile_img : String{
        return mediaBaseUrl + img_sublink
    }
    
    init(from json: JSON)
    {
        self.user_id = json["user_id"].stringValue
        self.name = json["owner_name"].stringValue
        self.img_sublink = json["owner_image"].stringValue
    }
}

enum feed_response_status : Int{
    case notResponded = 0
    case liked
    case rejected
}

struct Feed_Model {
    var id: String
    var user_id: String
    var isLiked = false
    var comment_count = "34"
    var tags = [String]()
    var like_count = "24"
    var feedText : String 
    
    var feed_img : String{
        return mediaBaseUrl + imgSubLink
    }
    var feed_owner : Feed_UserModel
    var feed_time  =  "15 Dec 2022 at 09:42 AM"
    var imgSubLink  =  "15 Dec 2022 at 09:42 AM"
    var type : String
    var responseStatus: feed_response_status{
        if type == "1" { return .liked} else
        if type == "2" { return .rejected} else{
            return .notResponded
        }
    }
    var isMyStory : Bool{
        return user_id == loggedinUser.id ? true : false
    }
    var isImage : Bool{
        return  imgSubLink.isEmpty ? false :  true
    }
    
    init(from json: JSON)
    {
        self.id = json["id"].stringValue
        self.user_id = json["user_id"].stringValue
        self.feedText = json["feed_title"].stringValue
        self.imgSubLink = json["feed_image"].stringValue
        self.feed_time = json["created_at"].stringValue
        let tag = json["tag"].stringValue
        self.tags = tag.components(separatedBy: ",")
        self.feed_owner = Feed_UserModel(from: json)
        self.type = json["type"].stringValue
    }
}
