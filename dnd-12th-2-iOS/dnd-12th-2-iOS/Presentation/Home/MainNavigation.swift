//
//  MainNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import ComposableArchitecture

@Reducer
struct MainNavigation {
    @Reducer
    enum Path {
        case home(HomeNavigation)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case path(StackActionOf<Path>)
        case goToHome
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                // MARK: - MainView
            case .goToHome:
                state.path.append(.home(.init()))
                return .none
                // MARK: - Flow
            case let .path(action):
                switch action {
                    // home -> main
                case let .element(id: id, action: .home(.backButtonTapped)):
                    state.path.pop(from: id)
                    return .none
                default:
                    return .none
                }
                return .none
            default:
                return .none
            }
        }  .forEach(\.path, action: \.path)
    }
}
