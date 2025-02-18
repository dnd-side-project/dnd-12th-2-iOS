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
    static let provider = MoyaProvider<TestAPI>(session: Session(interceptor: AuthIntercepter.shared))
}

extension TestClient: DependencyKey {
    static let liveValue = Self {
       
        let result: BaseResponse<String> = try await provider.async.request(.hello)
        return result.data ?? "nil"
    }
}

extension DependencyValues {
  var testClient: TestClient {
    get { self[TestClient.self] }
    set { self[TestClient.self] = newValue }
  }
}

