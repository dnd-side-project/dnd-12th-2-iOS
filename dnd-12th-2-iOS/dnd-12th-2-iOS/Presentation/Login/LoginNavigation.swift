//
//  LoginNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture
import AuthenticationServices

@Reducer
struct LoginNavigation {
    // Navigation
    @Reducer
    enum Path {
        case onboadingScreen(OnboardingFeature)
        case goalScreen(InitialGoalFeature)
        case resultScreen(GoalFeature)
        case initialGoalScreen(InitialGoalFeature)
    }
    
    @ObservableState
    struct State {
        // Navigation Path
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case goToOnboading
        case goToGoalSetting
        case goToMain
        case appleLoginButtonTapped(ASAuthorization)
        case appleLoginComplete(AppleLoginResDto)
    }
    
    @Dependency(\.authClient) var authClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .appleLoginButtonTapped(authorization):
                guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                      let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) else {
                    return .none
                }
                return .run { send in
                    let result = try await authClient.signIn(IdentityToken)
                    await send(.appleLoginComplete(result))
                }
            case let .appleLoginComplete(response):
                // 키체인 저장
                KeyChainManager.addItem(key: .accessToken, value: response.jwtTokenDto.accessToken)
                KeyChainManager.addItem(key: .refreshToken, value: response.jwtTokenDto.refreshToken)
                return .send(.goToMain)
            case .goToGoalSetting:
                return .none
            case .goToOnboading:
                state.path.append(.onboadingScreen(.init()))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .onboadingScreen(.completeButtonTapped)):
                    state.path.append(.initialGoalScreen(.init()))
                    return .none
                case .element(id: _, action: .goalScreen(.completeButtonTapped)):
                    state.path.append(.resultScreen(.init()))
                    return .none
                case .element(id: _, action: .resultScreen(.resultButtonTapped)):
                    return .send(.goToGoalSetting)
                case .element(id: _, action: .initialGoalScreen(.completeButtonTapped)):
                    return .send(.goToMain)
                default:
                    return .none
                }
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        ._printChanges()
    }
}

