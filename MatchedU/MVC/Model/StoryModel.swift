//
//  StoryModel.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.
//

import Foundation
import SwiftyJSON

// MARK: - UserModel

struct StoryModel {
    var id , subUrl , title , user_id : String
    var iLiked : Bool
    var imgUrl : String{
         "https://smartappsplanet.com/matchedu/"+subUrl
    }
    
    var isMyStory : Bool{
        return user_id == loggedinUser.id ? true : false
    }
    
    init(from json: JSON)
    {
        self.id = json["id"].stringValue
        self.subUrl =  json["doc_image"].stringValue
        self.title = json["doc_title"].stringValue
        self.user_id = json["user_id"].stringValue
        self.iLiked = json["document_like"].boolValue
    }
}
