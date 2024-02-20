//
//  Feed_Model.swift
//  WonderLive
//
//  Created by Taimur imam on 26/12/23.
//

import Foundation
import SwiftyJSON

struct Feed_UserModel{
    var name = "William Vangh"
    var id: String
    let profile_img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.BOgoQKyG0N_RfsRhyzwp_QHaFj%26pid%3DApi&f=1&ipt=73c6a6a41a38b121c18d783c2b1332acd80f3bed23da816cd3335fcede218dd8&ipo=images"

}

struct Feed_Model {
    var id: String
    var user_id: String
    var isLiked = false
    var comment_count = "34"
    var like_count = "24"
    var feedText = "Ordinary design translates into applied art, architecture, and various other creative achievements. In a sentence, the word can be used as either a noun or a verb. As a verb..."
    var feed_img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.uXPJDoBupEgP_0cg3PZqwwHaD2%26pid%3DApi&f=1&ipt=2eefdc8fcab4b9538698aa641cf149d914f80d9a3a7da831a8fec233f453f38d&ipo=images"
    var feed_owner = Feed_UserModel( id: "")
    var feed_time  =  "15 Dec 2022 at 09:42 AM"
    var isMyStory : Bool{
        return user_id == loggedinUser.id ? true : false
    }
    var isImage : Bool{
        return arc4random_uniform(2) == 0
    }
    init(from json: JSON)
    {
        self.id = json["id"].stringValue
        self.user_id = json["user_id"].stringValue

    }
}
