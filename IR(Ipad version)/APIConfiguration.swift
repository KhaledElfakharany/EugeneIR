//
//  APIConfiguration.swift
//  Intelligent Recommendations
//
//  Created by Иван on 20.05.17.
//
//

import Foundation

struct APIConfiguration {
    static let baseURLString = "https://dev.ir-system.com/picksapp/v1"
    static let headers = ["Content-Type": "application/x-www-form-urlencoded"]
}

extension APIConfiguration {
    static func URLString(_ path: String) -> String {
        return "\(baseURLString)\(path)"
    }
}
