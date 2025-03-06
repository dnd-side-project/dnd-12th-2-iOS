//
//  GoalClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation
import ComposableArchitecture
import Moya

struct GoalClient {
    var makeGoal: (GoalInfo) async throws -> Void
    var makePlan: (GoalInfo) async throws -> Void
    var fetchGoal: () async throws -> [Goal]
    static let provider = MoyaProvider<GoalAPI>(session: Session(interceptor: AuthIntercepter.shared), plugins: [MoyaLoggingPlugin()])
}

extension GoalClient: DependencyKey {
    static let liveValue = Self (
        makeGoal: { goalInfo in
            do {
                try await provider.async.requestPlain(.makeGoalWithPlan(goalInfo.toDto()))
            } catch {
                throw error
            }
        },
        makePlan: { goalInfo in
            
        }, fetchGoal: {
            do {
                let result: BaseResponse<[GoalResonseDto]> = try await provider.async.request(.fetchGoal)
                guard let result = result.data else {
                    throw APIError.parseError
                }
                return result.toDomain()
            } catch {
                throw error
            }
        }
    )
}

extension DependencyValues {
    var goalClient: GoalClient {
        get { self[GoalClient.self] }
        set { self[GoalClient.self] = newValue }
    }
}
