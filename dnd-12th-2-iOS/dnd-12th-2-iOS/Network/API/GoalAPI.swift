//
//  GoalAPI.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation
import Moya

enum GoalAPI {
    case makeGoalWithPlan(GoalReqDto)
    case makePlan
}

extension GoalAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/goals")!
    }
    
    var path: String {
        switch self {
        case .makeGoalWithPlan:
            return "/with-plan"
        case .makePlan:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .makeGoalWithPlan:
            return .post
        case .makePlan:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .makeGoalWithPlan(goalReqDto):
            return .requestJSONEncodable(goalReqDto)
        case let .makePlan:
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
