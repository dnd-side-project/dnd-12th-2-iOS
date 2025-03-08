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
    var fetchQuestion: () async throws -> [Question]
    var createOnboarding: ([Question]) async throws -> Void
    static let provider = MoyaProvider<UserAPI>(session: Session(interceptor: AuthIntercepter.shared), plugins: [MoyaLoggingPlugin()])
}

extension UserClient: DependencyKey {
    static let liveValue = Self (
        fetchUserOnboarding: {
            do {
                let result: BaseResponse<UserOnboardingResDto> = try await provider.async.request(.meOnboarding)
                guard let data = result.data else {
                    throw APIError.parseError
                }
                return data.checkOnboardingDone
            } catch {
                throw error
            }
        },
        fetchQuestion: {
            let result: BaseResponse<[OnboardingResDto]> = try await provider.async.request(.onboarding)
            guard let data = result.data else {
                throw APIError.parseError
            }
            return data.toDomain()
        },
        createOnboarding: { questions in
            do {
                try await provider.async.requestPlain(.createOnboarding(questions.toDto()))
            } catch {
                throw error
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
