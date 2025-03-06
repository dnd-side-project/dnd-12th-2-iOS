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
    var fetchTips: () async throws -> Guide
    static let provider = MoyaProvider<GuideAPI>(session: Session(interceptor: AuthIntercepter.shared), plugins: [MoyaLoggingPlugin()])
}

extension GuideClient: DependencyKey {
    static let liveValue = Self (
        fetchTips: {
            do {
                let result: BaseResponse<GuideResponseDto> = try await provider.async.request(.fetchNewTip)
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
    var guideClient: GuideClient {
        get { self[GuideClient.self] }
        set { self[GuideClient.self] = newValue }
    }
}
