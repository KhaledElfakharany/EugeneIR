//
//  User.swift
//  Intelligent Recommendations
//
//  Created by  Dmitry Babinsky on 21/05/17.
//
//

import Foundation

struct User {
    
    private let kEmailKey = "EmailKey"
    private let kPasswordKey = "PasswordKey"
    
    let email: String
    let password: String
    
    init(withEmail email: String, andPassword password: String) {
        self.email = email
        self.password = password
    }

    
    
}
