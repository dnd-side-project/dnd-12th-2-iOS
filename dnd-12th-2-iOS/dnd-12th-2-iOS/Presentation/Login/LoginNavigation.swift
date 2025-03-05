//
//  LoginNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture
import AuthenticationServices

@Reducer
struct LoginNavigation {
    @Reducer
    enum Path {
        case onboarding(Onboarding)
        case setFirstGoal(FirstGoalFlow)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        
        init(isOnboarding: Bool = false) {
            if isOnboarding {
                self.path.append(.onboarding(.init()))
            }
        }
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        
        // 애플로그인 버튼탭
        case appleLoginButtonTapped(ASAuthorization)
        
        // 애플로그인 완료
        case appleLoginComplete(AppleLoginResDto)
        
        // 로그인완료시 로그인체크
        case loginCheckRequest
        
        // 메인으로 이동
        case goToMain
        
        // 온보딩으로 이동
        case goToOnboarding
    }
    
    @Dependency(\.authClient) var authClient
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                // MARK: - Flow
            case let .path(action):
                switch action {
                case .element(id: _, action: .onboarding(.goToFirstGoalView)):
                    state.path.append(.setFirstGoal(.init()))
                    return .none
                case .element(id: _, action: .setFirstGoal(.goToMain)):
                    return .send(.goToMain)
                default:
                    return .none
                }
                // MARK: - LoginComplete
            case let .appleLoginButtonTapped(authorization):
                guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                      let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) else {
                    return .none
                }
                // TODO: 로그인한 유저 온보딩 완료여부 확인 처리
                return .concatenate([
                    .run { send in
                        let result = try await authClient.signIn(IdentityToken)
                        await send(.appleLoginComplete(result))
                    },
                    .run { send in
                        let _ = try await userClient.fetchUserOnboarding()
                        await send(.goToMain)
                    } catch: { error, send in
                        // 온보딩 데이터가 없는 경우 예외가 발생한다
                        await send(.goToOnboarding)
                    }
                ])
            case let .appleLoginComplete(response):
                KeyChainManager.addItem(key: .accessToken, value: response.jwtTokenDto.accessToken)
                KeyChainManager.addItem(key: .refreshToken, value: response.jwtTokenDto.refreshToken)
                return .none
            default:
                return .none
            }
        }.forEach(\.path, action: \.path)
    }
}
