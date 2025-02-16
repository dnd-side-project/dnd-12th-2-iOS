//
//  TestAPI.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/16/25.
//

import Foundation
import Moya

enum TestAPI {
    case hello
}

extension TestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)")!
    }
    
    var path: String {
        switch self {
        case .hello:
            "/hello"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .hello:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .hello:
            .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
