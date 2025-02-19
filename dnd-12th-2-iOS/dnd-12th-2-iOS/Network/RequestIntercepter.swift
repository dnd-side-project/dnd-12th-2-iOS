//
//  RequestIntercepter.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

import Foundation
import Alamofire
@preconcurrency import Moya

final class AuthIntercepter: RequestInterceptor {
    
    static let shared = AuthIntercepter()
    
    private init() {}
    
    private let retryLimit = 2
    private let provier = MoyaProvider<AuthAPI>()
    
    // API 요청전 호출
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("======RequestIntercepter - adapt======")
        // BaseUrl인 경우 헤더에 토큰 추가
        guard urlRequest.url?.absoluteString.hasPrefix(SecretKey.baseUrl) == true else { return }
        var urlRequest = urlRequest
        let accessToken = KeyChainManager.readItem(key: .accessToken) ?? ""
        print("Bearer \(accessToken)")
        urlRequest.headers.add(.authorization("Bearer \(accessToken)"))
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: any Error, completion: @escaping @Sendable (Alamofire.RetryResult) -> Void) {
        print("======RequestIntercepter - retry======")
        // 토큰 인증오류
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        // refreshToken 요청
        if request.retryCount < self.retryLimit && KeyChainManager.readItem(key: .refreshToken) != nil {
            provier.request(.refreshToken) { result in
                switch result {
                case let .success(response):
                    guard let result = try? response.map(BaseResponse<AppleLoginResDto>.self) else {
                        completion(.doNotRetry)
                        return
                    }
                    
                    guard let result = result.data else {
                        completion(.doNotRetry)
                        return
                    }
                    // 토큰 업데이트
                    KeyChainManager.updateItem(key: .accessToken, value: result.jwtTokenDto.accessToken)
                    KeyChainManager.updateItem(key: .refreshToken, value: result.jwtTokenDto.refreshToken)
                    completion(.retry)
                case let .failure(error):
                    
                    completion(.doNotRetryWithError(error))
                }
            }            
        } else {
            completion(.doNotRetryWithError(APIError.invalidToken))
        }
    }
}
