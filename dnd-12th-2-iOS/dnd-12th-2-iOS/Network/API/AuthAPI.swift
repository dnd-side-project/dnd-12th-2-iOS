//
//  AuthAPI.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/17/25.
//

import Foundation
import Moya

enum AuthAPI {
    case appleLogin(AppleLoginReqDto)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/auth")!
    }
    
    var path: String {
        switch self {
        case .appleLogin:
            "/login/apple"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .appleLogin:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .appleLogin(appleLoginReqDto):            
           return Task.requestJSONEncodable(appleLoginReqDto)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
