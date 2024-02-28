
//  API.swift
//  Football
//  Created by Taimur imam on 16/05/23.

import Foundation
import Alamofire

class APIFetchHandler {
    static let sharedInstance = APIFetchHandler()
    
    func fetchAPIData(completion : @escaping(_ models : [Model] ,_ isSuscess : Bool)->Void)->Void {
      let url = "https://jsonplaceholder.typicode.com/posts";
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
        .response{ resp in
            switch resp.result{
              case .success(let data):
                do{
                  let jsonData = try JSONDecoder().decode([Model].self, from: data!)
                    completion(jsonData, true)
                    return
                  print(jsonData)
               } catch {
                  print(error.localizedDescription)
                   completion([Model](), false)
                   return
               }
            case .failure(_):
                completion([Model](), false)
                return
             }
        }
   } 
}


struct UserApiCall{
    // Login API
    func Login(email : String , password : String  ,  onCompletion: @escaping (_ _response : ResponseModel ,  _ isSuccess: Bool ) -> Void) {
        showHud()
        let params = [
            "email" : email ,
            "password" : password
        ]
        APIManager.callWith( method: .post  , urlString: UserAPIs.login , withParams:params ) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel  ,isSuccess)
        }
        
    }
    
    // Creat New Account
    func registerNewAccount( params : Dictionary< String, Any>,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        APIManager.callWith(  method: .post , urlString: UserAPIs.signup , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }
    //
    
    // Creat New Account
    func getUserList( params : Dictionary< String, Any>,  onCompletion: @escaping ( _ _response : ResponseModel ) -> Void) {
        showHud()
        APIManager.callWith(  method: .post , urlString: UserAPIs.userList , withParams: params) { responseModel in
            hideHud()
            onCompletion(responseModel)
        }
    }
    //
    
    
    func getAllInterest(  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        APIManager.callWith(  method: .post , urlString: UserAPIs.interestList) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }

    
    // Add New Interest *******
    
    func addNewInterest( interest : String ,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        let params = [
            "interest_name" : interest
        ]
        APIManager.callWith(  method: .post , urlString: UserAPIs.profileDetails , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }
    
    
    // User Profile Detials
    func userProfileOf( user_id : String ,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        let params = [
            "user_id" : user_id
        ]
        APIManager.callWith(  method: .post , urlString: UserAPIs.profileDetails , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }
    
    // Creat New Account
    func editProfile( params : Dictionary< String, Any>,  onCompletion: @escaping ( _ _response : ResponseModel ) -> Void) {
        showHud() 
        APIManager.callWith(urlString: UserAPIs.profileEdit , withParams: params) { respM in
            onCompletion(respM)
            hideHud()
        }
    }
    
    
    func editProfileAndprofileImage( params : Dictionary< String, Any> , images : [UIImage] , imageFileName : [String] ,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        
        APIManager.putMultipartDataWithMultipleImage(urlString:UserAPIs.profileEdit , withParams: params , imageFiles: images, arrImageNames: imageFileName) { respM in
            let isSuccess = respM.isSuccess
            onCompletion(respM, isSuccess)
        }
        
//        APIManager.postMultipartData(urlString: UserAPIs.profileEdit , withParams: params, imageFile: images[0], strImageName: imageFileName[0]) { respM in
//            
//        }
    }
    
    
    // Forget Password OTP Send
    
    func forgetPasswordOTPSend( email : String ,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        let params = [
            "email" : email
        ]
        APIManager.callWith(  method: .post , urlString: UserAPIs.forgetEmailOTPSend , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }
    
    
    func verifyOTP( otp : String , email : String ,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        let params = [
            "email" : email,
            "otp" : otp
        ]
        APIManager.callWith(  method: .post , urlString: UserAPIs.verifyOTP , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }

    // Change password for forget password
    func changePassword( new_password : String , email : String ,  onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        let params = [
            "email" : email,
            "new_password" : new_password
        ]
        APIManager.callWith(  method: .post , urlString: UserAPIs.verifyOTP , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }
    
    
    // User Logout Api
    func logOut(    onCompletion: @escaping ( _ _response : ResponseModel ,  _ isSuccess: Bool) -> Void) {
        showHud()
        let params = [ "user_id" : loggedinUser.id]
        APIManager.callWith(  method: .post , urlString: UserAPIs.logOut , withParams: params) { responseModel in
            hideHud()
            let isSuccess = responseModel.isSuccess
            onCompletion(responseModel, isSuccess)
        }
    }
    
}


struct Model  : Codable {
    let userId: Int
    let id: Int
    var title = ""
    var body = ""
    var isLiked : Bool? = false
}

enum KeyboardType  : Int{
    case name = 0
    case email
    case number
}

var strStorage = ""


   



    

    

 


