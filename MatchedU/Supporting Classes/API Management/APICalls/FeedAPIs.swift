//
//  FeedAPIs.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import Foundation
import UIKit

struct FeedApiCall{
    // Creat New Feed
    func creatNewFeed(  feedTitle : String , img : UIImage ,  onCompletion: @escaping (_ _response : ResponseModel  ) -> Void) {
        showHud()
        let params = [
            "user_id" : loggedinUser.id ,
            "feed_title" : feedTitle
        ]
        APIManager.postMultipartData(urlString: FeedAPIs.addFeed , withParams: params, imageFile: img, strImageName: "doc_image") { responseModel in
            hideHud()
            onCompletion(responseModel)
        }
    }
      
    // Get Feed List
    func getFeedList(page: String , onCompletion: @escaping (_ _response : ResponseModel ) -> Void) {
        showHud()
        let params = [
            "page" : page
        ]
        APIManager.callWith(urlString: FeedAPIs.feedList , withParams: params) { respM in
            hideHud()
            onCompletion(respM)
        }
    }
    
    // Delete Feed by feedId
    func deleteFeed(feed_id: String , onCompletion: @escaping (_ _response : ResponseModel ) -> Void) {
        showHud()
        let params = [
            "feed_id" : feed_id
        ]
        APIManager.callWith(urlString: FeedAPIs.deleteFeed , withParams: params) { respM in
            hideHud()
            onCompletion(respM)
        }
    }
    
    
    
    
    
}
