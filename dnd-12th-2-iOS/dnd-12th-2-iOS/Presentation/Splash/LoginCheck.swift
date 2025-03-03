//
//  LoginCheck.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct LoginCheck {
    struct State: Equatable {}
    
    enum Action {
        // 로그인체크
        case loginCheck
        // 로그인 완료(온보딩x)
        case loginComplete
        // 온보딩 완료
        case onboardingComplete
        // 로그인 필요
        case loginNotComplete
    }
    
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loginCheck:
                // 온보딩 완료여부 체크
                let isLogin = KeyChainManager.readItem(key: .accessToken) != nil && KeyChainManager.readItem(key: .refreshToken) != nil
                return .run { send in
                    // TODO: 단순히 온보딩 데이터가 없는경우 예외처리
                    let isOnboarding = try await userClient.fetchUserOnboarding()
                    
                    if isOnboarding && isLogin {
                        await send(.onboardingComplete)
                    } else if isLogin {
                        await send(.loginComplete)
                    } else {
                        await send(.loginNotComplete)
                    }
                } catch: { error, send in
                    if isLogin {
                        await send(.loginComplete)
                    } else {
                        await send(.loginNotComplete)
                    }
                }
            default:
                return .none
            }
        }
    }
}
