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
    case fetchGoal
}

extension GoalAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/goals")!
    }
    
    var path: String {
        switch self {
        case .makeGoalWithPlan:
            return "/with-plan"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .makeGoalWithPlan:
            return .post
        case .makePlan:
            return .post
        case .fetchGoal:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .makeGoalWithPlan(goalReqDto):
            return .requestJSONEncodable(goalReqDto)
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
