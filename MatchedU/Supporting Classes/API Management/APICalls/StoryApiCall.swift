//
//  StoryApiCall.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.
//

import Foundation
import Alamofire

struct StoryApiCall{
    
    func creatNewStory(  storyTitle : String , img : UIImage ,  onCompletion: @escaping (_ _response : ResponseModel  ) -> Void) {
        showHud()
        let params = [
            "user_id" : loggedinUser.id ,
            "doc_title" : storyTitle
        ]
        APIManager.postMultipartData(urlString: UserAPIs.addStory , withParams: params, imageFile: img, strImageName: "doc_image") { responseModel in
            onCompletion(responseModel)
        }
    }
    
    //Delete Story
    
    func DeleteStory( story_id : String  ,  onCompletion: @escaping (_ _response : ResponseModel  ) -> Void) {
        showHud()
        let params = [
            "document_id" : story_id ,
        ]
        APIManager.callWith( method: .post  , urlString: UserAPIs.deleteStory , withParams:params ) { responseModel in
            hideHud()
            onCompletion(responseModel )
        }
    }
    
     
}
