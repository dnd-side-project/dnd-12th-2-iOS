//
//  LoginNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct LoginNavigation {
    @Reducer
    enum Path {
        case onboadingScreen(OnboardingFeature)
        case goalScreen(GoalFeature)
        case resultScreen(GoalFeature)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case goToOnboading
        case goToGoalSetting
        case goToMain
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .goToGoalSetting:
                return .none
            case .goToOnboading:
                state.path.append(.onboadingScreen(.init()))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .onboadingScreen(.completeButtonTapped)):
                    state.path.append(.goalScreen(.init()))
                    return .none
                case .element(id: _, action: .goalScreen(.completeButtonTapped)):
                    state.path.append(.resultScreen(.init()))
                    return .none
                case .element(id: _, action: .resultScreen(.resultButtonTapped)):
                    return .send(.goToMain)                    
                default:
                    return .none
                }
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
    
