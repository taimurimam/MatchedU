//
//  UserModel.swift
//  MatchedU
//
//  Created by Taimur imam on 13/02/24.
//


import Foundation
import SwiftyJSON

// MARK: - UserModel

enum Conection_Status : Int {
    case notConected = 0
    case conected
    case rejected
    case notSpecified
}

struct UserModel {
    var id: String
    var name, username, email, country_code, phone_number , dob , bio , collage , graduation_year , linkdin_url , gender: String
    var access_token: String
    var profile_image: String{
        return  mediaBaseUrl + profile_subLink
    }
    
    var cover_image: String{
        return  mediaBaseUrl + cover_sublink
    }
    
    var profile_subLink: String
    var cover_sublink: String
    var Conection_mode : String
    var tags: [TagViewItem]
    var stories : [StoryModel]
    
    var conectionStatus : Conection_Status{
        if Conection_mode == "0"
        {
            return .notConected
        }else if Conection_mode ==  "1" {
            return .conected
        }else if Conection_mode == "2"{
            return .rejected
        }else{
            return .notSpecified
        }
    }
    
    var isMyProfile : Bool{
        return id == loggedinUser.id ? true : false
    }
    
    var birthYear : String{
        if dob.isEmpty{
            return ""
        }else{
            return  dob.components(separatedBy: "-").last ?? ""
        }
    }
    
    init(from json: JSON)
    {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.username = mediaBaseUrl + json["username"].stringValue
        self.country_code = json["country_code"].stringValue
        self.phone_number = json["phone_number"].stringValue
        self.access_token = json["api_token"].stringValue
        self.profile_subLink = json["image"].stringValue
        self.dob = json["dob"].stringValue
        self.bio = json["about_me"].stringValue
        self.collage = json["qualification"].stringValue
        self.graduation_year = json["qualification_year"].stringValue
        self.linkdin_url = json["linkedin_url"].stringValue
        self.gender = json["gender"].stringValue
        self.cover_sublink = json["cover_image"].stringValue //connect_status
        self.stories = json["user_document"].arrayValue.map { StoryModel(from: $0 )}
        self.tags = json["tag"].arrayValue.map { TagViewItem(from: $0 )}
        self.Conection_mode = json["connect_status"].stringValue //connect_status

    }
}

class LogedInUser : ObservableObject{
    @Published var user = loggedinUser
}
