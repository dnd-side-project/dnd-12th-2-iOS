//
//  HomeNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct HomeNavigation {
    @Reducer
    enum Path {
        case feedbackScreen
    }
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {            
            case let .path(action):
                switch action {
                case .element(id: _, action: .feedbackScreen):
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: \.path)
    }
}
