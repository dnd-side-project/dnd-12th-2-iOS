//
//  AppleClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/16/25.
//

import Foundation
import ComposableArchitecture
import AuthenticationServices
import Moya

struct AuthClient {
    var signIn: (String) async throws -> AppleLoginResDto
    var signOut: () async throws -> Void
    
    static let provider = MoyaProvider<AuthAPI>()
}

extension AuthClient: DependencyKey {
    static let liveValue = Self (
        signIn: { idToken in
            do {
                let result: BaseResponse<AppleLoginResDto> = try await provider.async.request(.appleLogin(.init(code: idToken, deviceToken: "deviceToken")))
                guard let result = result.data else {
                    throw APIError.parseError
                }
                return result
            } catch {
                print(error.localizedDescription)
                throw error
            }
        },
        signOut: {
            do {
                try await provider.async.requestPlain(.logout)
            } catch {
                print(error.localizedDescription)
                throw error
            }
        }
    )
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
