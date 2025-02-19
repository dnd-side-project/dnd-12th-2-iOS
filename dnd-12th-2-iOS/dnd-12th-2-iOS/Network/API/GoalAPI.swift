//
//  GoalAPI.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import Foundation
import Moya

enum GoalAPI {
    case fetchGoals
}

extension GoalAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/goals")!
    }
    
    var path: String {
        switch self {
        case .fetchGoals:
            ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchGoals:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchGoals:
            .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
         return .successCodes
     }
}
