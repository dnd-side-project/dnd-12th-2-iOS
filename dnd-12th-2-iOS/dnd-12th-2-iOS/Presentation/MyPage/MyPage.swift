//
//  MyPage.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct MyPage {
    struct State {}
    
    enum Action {
        case logoutButtonTapped
        case logoutComplete
    }
    
    @Dependency(\.authClient) var authClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .logoutButtonTapped:
                return .run { send in
                    try await authClient.signOut()                    
                    await send(.logoutComplete)
                }
            case .logoutComplete:
                KeyChainManager.deleteItem(key: .accessToken)
                KeyChainManager.deleteItem(key: .refreshToken)
                return .none
            }
        }
    }
}

