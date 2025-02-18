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
    var getUserOnboarding: () async throws -> Bool
    var getOnboarding: () async throws -> Void
    static let provider = MoyaProvider<UserAPI>(session: Session(interceptor: AuthIntercepter.shared))
}

extension UserClient: DependencyKey {
    static let liveValue = Self (
        getUserOnboarding: {
            do {
                try await provider.async.requestPlain(.meOnboarding)
                return true
            } catch {
                return false
            }
        },
        getOnboarding: {
            
        }
    )
}

extension DependencyValues {
  var userClient: UserClient {
    get { self[UserClient.self] }
    set { self[UserClient.self] = newValue }
  }
}
