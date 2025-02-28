//
//  LoginNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct LoginNavigation {
    @Reducer
    enum Path {
        case onboarding
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        
        init(isOnboarding: Bool = false) {
            if isOnboarding {
                self.path.append(.onboarding)
            }
        }
    }
    
    enum Action {
        case path(StackActionOf<Path>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }.forEach(\.path, action: \.path)
    }
}
