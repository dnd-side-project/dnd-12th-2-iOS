//
//  UserAPI.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

import Foundation
import Moya

enum UserAPI {
    case meOnboarding
    case onboarding
    case createOnboarding(OnboardingReqDto)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(SecretKey.baseUrl)/api")!
    }
    
    var path: String {
        switch self {
        case .meOnboarding:
            "/user/onboarding"
        case .onboarding:
            "/onboarding"
        case .createOnboarding:
            "/user/onboarding"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .meOnboarding:
                .get
        case .onboarding:
                .get
        case .createOnboarding:
                .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .meOnboarding:
                .requestPlain
        case .onboarding:
                .requestPlain
        case  let .createOnboarding(onboardingReqDto):
                .requestJSONEncodable(onboardingReqDto)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
