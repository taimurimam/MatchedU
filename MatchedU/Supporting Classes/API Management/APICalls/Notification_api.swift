//
//  Notification_api.swift
//  MatchedU
//
//  Created by Taimur imam on 01/03/24.
//

import Foundation
struct notificationApiCall{
    // Notification List
    
    func notificationList(   onCompletion: @escaping (_ _response : ResponseModel  ) -> Void) {
        let params = [
            "user_id" : loggedinUser.id ,
        ]
        APIManager.callWith(urlString: UserAPIs.notification_list , withParams:params ) { respM in
            hideHud()
            onCompletion(respM)
        }
    }
    
    func sendConectionRequest(secondParson_id : String  , onCompletion: @escaping (_ _response : ResponseModel  ) -> Void){
        showHud()
        let params = [
            "user_id" : loggedinUser.id ,
            "request_id" : secondParson_id
        ]
        APIManager.callWith(urlString: UserAPIs.connection_request , withParams:params ) { respM in
            hideHud()
            onCompletion(respM)
        }
    }
    
    func conectionRequestResponse(secondParson_id : String , responseType : String , onCompletion: @escaping (_ _response : ResponseModel  ) -> Void){
        showHud()
        let params = [
            "user_id" : loggedinUser.id ,
            "request_id" : secondParson_id ,
            "status" : responseType
        ]
        APIManager.callWith(urlString: UserAPIs.connect_status_update , withParams:params ) { respM in
            hideHud()
            onCompletion(respM)
        }
    }
    
    func conectionList( user_id : String  ,   onCompletion: @escaping (_ _response : ResponseModel  ) -> Void){
        let params = [
            "user_id" : user_id ,
        ]
        APIManager.callWith(urlString: UserAPIs.myConectionList , withParams:params ) { respM in
            onCompletion(respM)
        }
    }

    
    
    
    
}

