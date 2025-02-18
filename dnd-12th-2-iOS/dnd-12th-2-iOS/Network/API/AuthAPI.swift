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
    case logout
    case refreshToken
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/auth")!
    }
    
    var path: String {
        switch self {
        case .appleLogin:
            "/login/apple"
        case .logout:
            "/sign-out"
        case .refreshToken:
            "/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .appleLogin:
                .post
        case .logout:
                .post
        case .refreshToken:
                .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .appleLogin(appleLoginReqDto):
            return Task.requestJSONEncodable(appleLoginReqDto)
        case .logout:
            return .requestPlain
        case .refreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .refreshToken:
            return ["Content-type": "application/json",
                    "Authorization": "Bearer \(KeyChainManager.readItem(key: .refreshToken) ?? "")"]
        default:
            return ["Content-type": "application/json"]
        }
    }
}
