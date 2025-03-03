//
//  GuideClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation
import ComposableArchitecture
import Moya

struct GuideClient {
    static let provider = MoyaProvider<GoalAPI>(session: Session(interceptor: AuthIntercepter.shared), plugins: [MoyaLoggingPlugin()])
}

extension GuideClient: DependencyKey {
    static let liveValue = Self (
        
    )
}

extension DependencyValues {
    var guideClient: GoalClient {
        get { self[GuideClient.self] }
        set { self[GuideClient.self] = newValue }
    }
}
