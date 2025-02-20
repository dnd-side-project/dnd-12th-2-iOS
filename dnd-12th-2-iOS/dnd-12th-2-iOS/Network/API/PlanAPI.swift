//
//  PlanAPI.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/20/25.
//

import Foundation

import Moya

enum PlanAPI {
    case createInitialGoal(request: InitialGoal)
    case getTips
}

extension PlanAPI: TargetType {
    var baseURL: URL {
        return URL(string: SecretKey.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .createInitialGoal:
            return "/api/goals/with-plan"
        case .getTips:
            return "/api/user-guides/new"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createInitialGoal:
                return .post
        case .getTips:
                return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .createInitialGoal(initialGoal):
            return Task.requestJSONEncodable(initialGoal)
        case .getTips:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = KeyChainManager.readItem(key: .accessToken) else {
            return nil
        }
        return ["Content-type": "application/json",
                "Authorization": "Bearer \(token)"]
    }
}
