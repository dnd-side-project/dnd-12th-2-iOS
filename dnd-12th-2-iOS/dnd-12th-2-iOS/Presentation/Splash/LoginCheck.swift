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
                return .run { send in                    
                    let isOnboarding = try await userClient.fetchUserOnboarding()
                    let isLogin = KeyChainManager.readItem(key: .accessToken) != nil && KeyChainManager.readItem(key: .refreshToken) != nil
                    
                    if isOnboarding && isLogin {
                        await send(.onboardingComplete)
                    } else if isLogin {
                        await send(.loginComplete)
                    } else {
                        await send(.loginNotComplete)
                    }
                } catch: { error, send in
                    await send(.loginNotComplete)
                }
            default:
                return .none
            }
        }
    }
}
