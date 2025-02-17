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
                return .send(.loginCompleted(true))
            default:
                return .none
            }
        }
    }
}
