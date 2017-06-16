//
//  ApiRequests.swift
//  Intelligent Recommendations
//
//  Created by Khaled Elfakharany on 6/2/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//
//

import Foundation
import Alamofire

class ApiRequests {
    
    //MARK: - Public methods
    
    //LOGIN
    func login(with user: User, callback: @escaping (_:AuthData?,_ error: String?)->()) {
        self.loginRequest(with: user, callback: callback)
    }
    
    private func loginRequest(with user: User, callback: @escaping (_:AuthData?,_ error: String?)->()) {
        Alamofire.SessionManager.default.request(RequestsRouter.requestLogin(user: user)).responseJSON { response in
            if let json: Dictionary<String, Any> = response.result.value as! Dictionary<String, Any>? {
                let authData = AuthData(withDictionary: json)
                if authData.isOk == true {
                    callback(authData, nil)
                } else {
                    callback(nil, authData.errorMessage)
                }
            }
        }
    }
    
    //FORGOT PASSWORD
    
    func forgotPassword(for email: String, callback:@escaping (_ apiStatus:String, _ message:String, _ url:String?)->()) {
        Alamofire.SessionManager.default.request(RequestsRouter.requestPassword(email: email)).responseJSON { response in
            if let jsonResponse: Dictionary<String, Any> = response.result.value as? Dictionary<String, Any> {
                let status = jsonResponse["status"] as! String
                let sStatus = self.convert(string: status)
                let message = jsonResponse["status_message"] as! String
                let url = jsonResponse["password_reset_url"] as? String
                callback(sStatus, message, url)
            }
        }
    }
    // Registration
    
    func register(user: User,risikoneigung: String,anlagehorizont: String, completed: @escaping (_ regStatus:String, _ statusMessage:String)->()){
        
        Alamofire.request(APIConfiguration.URLString("/register/"), method: .post, parameters: ["email":user.email,"password": user.password,"risikoneigung": risikoneigung,"anlagehorizont": anlagehorizont], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            print("JSON: \(response)")
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                completed(status, statusMessage)
            }
        }
    }
    
    
    //FOR AA SCREEN REQUESTS
    
    func getCurrentAsset(from user: User, callback: @escaping (_ aa:[AA], _ remaining:Int)->()) {
        Alamofire.SessionManager.default.request(RequestsRouter.requestAA(user: user)).responseJSON { response in
            if let json: Dictionary<String, Any> = response.result.value as! Dictionary<String, Any>?  {
                print("response: \(json)")
                let currentAA = json["current_aa"] as! [Dictionary<String, Any>]
                let aa = AAData(array: currentAA)
                callback(aa.AAArray,aa.remaining)
            }
        }
    }
    
    func enterAA(user: User, data : String, completed: @escaping (_ enterStatus:String, _ statusMessage:String)->() ) {
        Alamofire.request(APIConfiguration.URLString("/enter_aa/"), method: .post, parameters: ["email":user.email,"password":user.password,"aa":data], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                completed(status, statusMessage)
            }
        }
    }
    
    func recommendationRequest(user: User, completed: @escaping (_ enterStatus:String, _ statusMessage:String, _ data: RecommendationData)->()){
        Alamofire.request(APIConfiguration.URLString("/get_recommendations_data/"), method: .post, parameters: ["email":user.email,"password":user.password], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                let ruleset = dict["ruleset"] as! [Dictionary<String,Any>]
                let recomendationItem = RecommendationData(array: ruleset)
                completed(status, statusMessage, recomendationItem)
            }
        }
    }
    
    func settingsRequest(user: User, newPassword: String, completed: @escaping (_ settStatus:String, _ statusMessage:String)->()){
        Alamofire.request(APIConfiguration.URLString("/set_password/"), method: .post, parameters: ["email":user.email, "password":user.password, "new_password":newPassword], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            print("sett: \(response)")
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                completed(status, statusMessage)
            }
        }
        
    }

    func aboutUsRequest(user: User, language: String, completed: @escaping (_ aboutStatus:String, _ statusMessage:String, _ data: AboutUsData)->()){
        Alamofire.request(APIConfiguration.URLString("/about_us/"), method: .post, parameters: ["email":user.email,"password":user.password, "language":language], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            print("about: \(response)")
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                let data = AboutUsData(dict: dict)
                completed(status, statusMessage, data)
            }
        }
    }
    
    func enterRecommendation(user: User, data : String,submit: Int, completed: @escaping (_ enterStatus:String, _ statusMessage:String,_ submitStatus: String)->() ) {
        Alamofire.request(APIConfiguration.URLString("/enter_recommendations/"), method: .post, parameters: ["email":user.email,"password":user.password,"recommendations":data,"submit":submit], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                let canBeSubmitted = dict["can_be_submitted"] as! Bool
                if canBeSubmitted{
                    completed(status, statusMessage, "Can Be Submitted")
                }else{
                completed(status, statusMessage, "Cannot be submitted")
                }
            }
        }
    }
    
    func saveRecommendation(user: User, completed: @escaping (_ enterStatus:String, _ statusMessage:String)->()){
        Alamofire.request(APIConfiguration.URLString("/get_recommendations_data/"), method: .post, parameters: ["email":user.email,"password":user.password], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                completed(status, statusMessage)
            }
        }
    }
    
    func picks(user: User,risk: Int, completed: @escaping (_ enterStatus:String, _ statusMessage:String, _ data: PicksData, _ month:Int, _ year: Int)->()){
        Alamofire.request(APIConfiguration.URLString("/get_picks/"), method: .post, parameters: ["email":user.email,"password":user.password], encoding: URLEncoding.default, headers: APIConfiguration.headers).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                let status = dict["status"] as! String
                let statusMessage = dict["status_message"] as! String
                let picks = dict["picks"] as! [Dictionary<String,Any>]
                print(picks)
                let data = PicksData(array: picks, currentRisk: risk)
                let month = dict["month"] as! Int
                let year = dict["year"] as! Int
                completed(status, statusMessage, data,month,year)
            }
        }
    }
    
    //MARK: - Additional Methods
    
    func convert(string: String) -> String {
        return string == "ok" ? "Successful" : "Fail"
    }
    
}
