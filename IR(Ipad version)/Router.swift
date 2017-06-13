//
//  Router.swift
//  Intelligent Recommendations
//
//  Created by Иван on 20.05.17.
//
//

import Alamofire
import AlamofireURLRequestConfigurable

//MARK: - AuthorizationRouter

enum RequestsRouter: URLRequestConfigurable {
    case requestLogin(user: User)
    case requestPassword(email: String)
    case requestRegister(user: User, risikoneigung: String, anlagehorizont: String)
    case requestAA(user: User)
//    case enterAA(assetA: AASend)
    
    var urlRequestConfiguration: URLRequestConfiguration {
        switch self {
        case .requestLogin(let user):
            let email = user.email
            let password = user.password
            return URLRequestConfiguration(
                url: APIConfiguration.URLString("/get_metadata/"),
                method: .post,
                parameters: ["email": email, "password": password],
                encoding: URLEncoding.default,
                headers: APIConfiguration.headers
            )
        case .requestPassword(let email):
            return URLRequestConfiguration(
                url: APIConfiguration.URLString("/request_password/"),
                method: .post,
                parameters: ["email": email],
                encoding: URLEncoding.default,
                headers: APIConfiguration.headers
            )
        case .requestRegister(let user, let risikoneigung, let anlagehorizont):
            let email = user.email
            let password = user.password
            return URLRequestConfiguration(
                url: APIConfiguration.URLString("/register/"),
                method: .post,
                parameters: ["email": email,
                             "password": password,
                             "risikoneigung": risikoneigung,
                             "anlagehorizont": anlagehorizont],
                encoding: URLEncoding.default,
                headers: APIConfiguration.headers
            )
        case .requestAA(let user):
            let email = user.email
            let password = user.password
            return URLRequestConfiguration(
                url: APIConfiguration.URLString("/get_current_aa/"),
                method: .post,
                parameters: ["email": email,
                             "password": password ],
                encoding: URLEncoding.default,
                headers: APIConfiguration.headers
            )
//        case .enterAA(let asset):
//            let email = asset.user.email
//            let password = asset.user.password
//            let aa = asset.aaArray
//            return URLRequestConfiguration(
//                url: APIConfiguration.URLString("/enter_aa/"),
//                method: .post,
//                parameters: ["email": email,
//                             "password": password,
//                             "aa" : aa],
//                encoding: URLEncoding.default,
//                headers: APIConfiguration.headers
//            )
        }
    }
}
