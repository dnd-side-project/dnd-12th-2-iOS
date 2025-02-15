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
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case logoutButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .logoutButtonTapped:
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
