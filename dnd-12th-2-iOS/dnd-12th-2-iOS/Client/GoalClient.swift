//
//  GoalClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import Foundation
import ComposableArchitecture
import Moya

struct GoalClient {
    var fetchGoalList: () async throws -> Void
    static let provider = MoyaProvider<GoalAPI>(session: Session(interceptor: AuthIntercepter.shared))
}

extension GoalClient: DependencyKey {
    static let fetchGoalList = Self {
               
    }
}

extension DependencyValues {
  var goalClient: GoalClient {
    get { self[GoalClient.self] }
    set { self[GoalClient.self] = newValue }
  }
}

