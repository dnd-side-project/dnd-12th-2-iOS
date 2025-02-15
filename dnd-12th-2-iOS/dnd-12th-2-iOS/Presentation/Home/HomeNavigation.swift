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
        case selecteScreen(FeedbackFeature)
        case completeScreen(FeedbackFeature)
        case resultScreen(FeedbackFeature)
    }
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case completeButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .completeButtonTapped:
                state.path.append(.selecteScreen(.init()))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .selecteScreen(.goToComplete)):
                    state.path.append(.completeScreen(.init()))
                    return .none
                case .element(id: _, action: .completeScreen(.goToResult)):
                    state.path.append(.resultScreen(.init()))
                    return .none
                case .element(id: _, action: .resultScreen(.completeButtonTapped)):
                    state.path.removeAll()
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: \.path)
        ._printChanges()
    }
}
