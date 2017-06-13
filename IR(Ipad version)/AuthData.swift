//
//  AuthData.swift
//  Intelligent Recommendations
//
//  Created by  Dmitry Babinsky on 20/05/17.
//
//

import Foundation

class AuthData {
    
    let isOk: Bool
    var metadata: Metadata?
    var errorMessage: String?
    
    init(withDictionary dic: Dictionary<String, Any>) {
        self.errorMessage = nil
        let status: String = dic["status"] as! String
        self.isOk = status == "ok" ? true : false
        
        if isOk == false {
            self.errorMessage = dic["status_message"] as! String?
        } else {
            metadata = Metadata(withDic: dic)
        }        
    }
    
}
