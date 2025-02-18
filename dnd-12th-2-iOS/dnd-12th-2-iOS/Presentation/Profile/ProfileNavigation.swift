//
//  ProfileNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct ProfileNavigation {
    @Reducer
    enum Path {
        case onboadingScreen
    }
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var result = ""
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case logoutButtonTapped
        case logoutComplete
        // Network Test
        case tesButtonTapped
        case testButtonComplete(String)
    }
    
    @Dependency(\.authClient) var authClient
    @Dependency(\.testClient) var tesetClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .testButtonComplete(response):
                state.result = response
                return .none
            case .tesButtonTapped:
                return .run { send in
                    let result = try await tesetClient.fetch()
                    await send(.testButtonComplete(result))
                }
            case .logoutButtonTapped:
                return .run { send in
                    do {
                        try await authClient.signOut()
                        await send(.logoutComplete)
                    } catch {
                        
                    }
                }
            case .logoutComplete:
                KeyChainManager.deleteItem(key: .accessToken)
                KeyChainManager.deleteItem(key: .refreshToken)
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .onboadingScreen):
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: \.path)
    }
}
