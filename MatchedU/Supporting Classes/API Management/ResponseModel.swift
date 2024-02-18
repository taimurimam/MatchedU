//
//  ResponseModel.swift
//
//  Copyright © 2023 Sk Azad. All rights reserved.
//

import UIKit
import SwiftyJSON


class ResponseModel
{
    //The called Url is stored here
    var strUrl = ""
    
    //Response status and message to understand if it's successful or failed
    var isSuccess = false
    var intResCode: Int = 0
    var strResMsg = "", strAuth = ""
    
    //Main dictionary value(in the form of JSON), which contains all the information we are suppossed to get from the url.
    var jsonResp = JSON()
    
    //Complete response(in the form of JSON) is kept here for any reference
    var completeJsonResp = JSON()
    
    //Storing RawData for reference
    var rawData = Data()
    
    init(_ strUrl: String = "", _ isSuccess: Bool = false, _ intResCode: Int = 0, _ strResMsg: String = failedToLoad, _ strAuth: String = "", _ jsonResp: JSON = JSON(), _ completeJsonResp: JSON = JSON(), rawData: Data = Data())
    {
        self.strUrl = strUrl
        
        self.isSuccess = isSuccess
        self.intResCode = intResCode
        self.strResMsg = strResMsg
        self.strAuth = strAuth
        
        self.jsonResp = jsonResp
        
        self.completeJsonResp = completeJsonResp
        
        self.rawData = rawData
    }
}

