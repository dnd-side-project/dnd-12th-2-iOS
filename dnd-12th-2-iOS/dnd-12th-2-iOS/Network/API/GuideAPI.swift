//
//  GuideAPI.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation
import Moya

enum GuideAPI {
    case fetchNewTip
    case fetchTip(type: String)
}

extension GuideAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/user-guides")!
    }
    
    var path: String {
        switch self {
        case .fetchNewTip:
            return "/new"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchTip(type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}
