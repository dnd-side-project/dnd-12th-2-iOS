//
//  SplashFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct SplashFeature {
    struct State: Equatable {}
    
    enum Action {
        case loginCheck
        case loginCompleted(Bool)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loginCheck:
                if KeyChainManager.readItem(key: .accessToken) != nil && KeyChainManager.readItem(key: .refreshToken) != nil {
                    return .send(.loginCompleted(true))
                } else {
                    return .send(.loginCompleted(false))
                }
                
            default:
                return .none
            }
        }
    }
}
