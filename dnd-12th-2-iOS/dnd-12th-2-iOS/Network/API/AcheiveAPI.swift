//
//  AcheiveAPI.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 3/8/25.
//

import Foundation

import Moya

enum AchieveAPI {
    case achieve(goalId: Int)
}

extension AchieveAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/goals")!
    }
    
    var path: String {
        switch self {
        case .achieve(let goalId):
            return "/\(goalId)/achieve"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .achieve:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .achieve(let goalId):
            
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
