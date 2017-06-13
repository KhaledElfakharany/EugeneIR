//
//  GetMetadata.swift
//  Intelligent Recommendations
//
//  Created by  Dmitry Babinsky on 21/05/17.
//  Edited and modified by Khaled Elfakharany on 30/5/2017
//

import Foundation

struct Metadata {
    
    let recommendations: Int
    let rating: Int
    let app_premium: Bool?
    let app_premium_since: String?
    let app_premium_to: String?
    let risikoneigung: Int
    let lock_functions: Bool
    let show_screen: String

    
    init(withDic dic: Dictionary<String, Any>) {
        self.recommendations =  dic["recommendations"] as! Int
        self.rating = dic["rating"] as! Int
//        self.app_premium = (dic["app_premium"] != "0")
        self.app_premium_since = dic["app_premium_since"] as? String
        if app_premium_since == nil {
            app_premium = false
        }else {
            app_premium = true
        }
        self.app_premium_to = dic["app_premium_to"] as? String
        self.risikoneigung = dic["risikoneigung"] as! Int
        self.lock_functions = (dic["lock_functions"] != nil)
        self.show_screen = dic["show_screen"] as! String
    }
    
}
