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
    var id , subUrl , title : String
    var imgUrl : String{
         "https://smartappsplanet.com/matchedu/"+subUrl
    }

    init(from json: JSON)
    {
        self.id = json["id"].stringValue
        self.subUrl =  json["doc_image"].stringValue
        self.title = json["doc_title"].stringValue
    }
}
