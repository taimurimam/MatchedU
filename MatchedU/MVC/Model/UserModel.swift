//
//  UserModel.swift
//  MatchedU
//
//  Created by Taimur imam on 13/02/24.
//


import Foundation
import SwiftyJSON

// MARK: - UserModel


struct UserModel {
    var id: String
    var name, username, email, country_code, phone_number , dob , bio , collage , graduation_year , linkdin_url: String
    var access_token: String
    var profile_image: String
    var tags: [Any]
    var stories : [StoryModel] 
    init(from json: JSON)
    {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.username = mediaBaseUrl + json["username"].stringValue
        self.country_code = json["country_code"].stringValue
        self.phone_number = json["phone_number"].stringValue
        self.access_token = json["api_token"].stringValue
        self.profile_image = json["profile_image"].stringValue
        self.tags = json["tag"].arrayValue
        self.dob = json["dob"].stringValue
        self.bio = json["about_me"].stringValue
        self.collage = json["qualification"].stringValue
        self.graduation_year = json["qualification_year"].stringValue
        self.linkdin_url = json["linkedin_url"].stringValue
        self.stories = json["user_document"].arrayValue.map { StoryModel(from: $0 )}
    }
}
