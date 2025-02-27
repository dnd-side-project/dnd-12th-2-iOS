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
    case fetchPlans(Int, String, Int)
    case fetchStatistics(Int, String)
}

extension GoalAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api/goals")!
    }
    
    var path: String {
        switch self {
        case .fetchGoals:
            ""
        case let .fetchPlans(goalId, _, _):
            "/\(goalId)/plans"
        case let .fetchStatistics(goalId, _):
            "/\(goalId)/statistics/weekly"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchGoals:
            .get
        case .fetchPlans:
            .get
        case .fetchStatistics:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchGoals:
            .requestPlain
        case let .fetchPlans(_, date, range):
                .requestParameters(parameters: ["date": date, "range": range], encoding: URLEncoding.queryString)
        case let .fetchStatistics(_, date):
            .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
         return .successCodes
     }
}
