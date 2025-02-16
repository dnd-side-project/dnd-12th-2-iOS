//
//  TestClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/16/25.
//

import Foundation
import ComposableArchitecture
import Moya

struct TestClient {
    var fetch: () async throws -> String
}

extension TestClient: DependencyKey {
    static let liveValue = Self {
        let provider = MoyaProvider<TestAPI>()
        let result: BaseResponse<String> = try await provider.async.request(.hello)
        return result.data
    }
}

extension DependencyValues {
  var testClient: TestClient {
    get { self[TestClient.self] }
    set { self[TestClient.self] = newValue }
  }
}

