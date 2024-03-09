//
//  TagViewItem.swift
//  MatchedU
//
//  Created by Taimur imam on 09/03/24.
//

import Foundation
import SwiftyJSON

struct TagViewItem: Hashable {
    
    var title: String
    var status: Bool
    var id = ""
    var is_interest = ""
    var isSelected : Bool{
        return self.is_interest == "1" ? true : false
    }
    
    init(from json: JSON)
    {
        self.title = json["interest_name"].stringValue
        self.status = json["status"].boolValue
        self.id = json["id"].stringValue
        self.is_interest = json["id"].stringValue
        
    }
    static func == (lhs: TagViewItem, rhs: TagViewItem) -> Bool {
        return lhs.isSelected == rhs.isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}
