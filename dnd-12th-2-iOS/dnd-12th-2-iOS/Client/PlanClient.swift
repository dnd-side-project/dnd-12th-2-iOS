//
//  PlanClient.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/20/25.
//

import Foundation

import Moya
import ComposableArchitecture

struct PlanClient {
    var createInitialGoal: (InitialGoal) async throws -> Void
    var getTips: () async throws -> Guide
    
    static let provider = MoyaProvider<PlanAPI>(session: Session(interceptor: AuthIntercepter.shared), plugins: [MoyaLoggingPlugin()])
}

extension PlanClient: DependencyKey {
    static let liveValue = Self(
        createInitialGoal: { initialGoal in
            do {
                try await provider.async.requestPlain(.createInitialGoal(request: initialGoal))
            } catch {
                print(error.localizedDescription)
                throw error
            }
        },
        getTips: {
            do {
                let result: BaseResponse<Guide> = try await provider.async.request(.getTips)
                guard let guide = result.data else {
                    throw APIError.parseError
                }
                return guide
            } catch {
                print(error.localizedDescription)
                throw error
            }
        }
    )
}

extension DependencyValues {
    var planClient: PlanClient {
        get { self[PlanClient.self] }
        set { self[PlanClient.self] = newValue }
    }
}
