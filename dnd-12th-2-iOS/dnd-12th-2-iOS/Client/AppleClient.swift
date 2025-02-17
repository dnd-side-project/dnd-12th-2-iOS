//
//  AppleClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/16/25.
//

import Foundation
import ComposableArchitecture
import AuthenticationServices

struct AppleClient {
    var signIn: () async throws -> Void
}

extension AppleClient: DependencyKey {
    static let liveValue = Self (
        signIn: {
           
        }
    )
}

extension DependencyValues {
    var appleLogin: AppleClient {
        get { self[AppleClient.self] }
        set { self[AppleClient.self] = newValue }
    }
}
