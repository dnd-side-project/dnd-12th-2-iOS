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
        var text = ""
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case logoutButtonTapped
        // Network Test
        case helloButtonTapped
        case helloButtonComplete(String)
    }
    
    @Dependency(\.testClient) var hello
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .helloButtonComplete(response):
                state.text = response
                return .none
            case .helloButtonTapped:
                return .run { send in
                    let result = try await hello.fetch()                    
                    await send(.helloButtonComplete(result))
                }
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
