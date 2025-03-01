//
//  UserClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

import Foundation
import ComposableArchitecture
import Moya

struct UserClient {
    var fetchUserOnboarding: () async throws -> Bool
    static let provider = MoyaProvider<UserAPI>(session: Session(interceptor: AuthIntercepter.shared))
}

extension UserClient: DependencyKey {
    static let liveValue = Self (
        fetchUserOnboarding: {
            do {
                try await provider.async.requestPlain(.meOnboarding)
                return true
            } catch {
                return false
            }
        }
    )
}

extension DependencyValues {
    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}
