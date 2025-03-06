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
        case setGoal(SetGoal)
        case myPage(MyPage)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case path(StackActionOf<Path>)
        case goToHome
        case goToSetGoalView
        case goToMyPage
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                // MARK: - MainView
            case .goToHome:
                state.path.append(.home(.init()))
                return .none
            case .goToSetGoalView:
                state.path.append(.setGoal(.init()))
                return .none
            case .goToMyPage:
                state.path.append(.myPage(.init()))
                return .none
                // MARK: - Flow
            case let .path(action):
                switch action {
                case let .element(id: id, action: .home(.backButtonTapped)):
                    state.path.pop(from: id)
                    return .none
                    // TODO: - 목표달성 연결
                case .element(id: _, action: .home(.goToArchiveGoal)):
                    // 목표달성 경로 추가
                    return .none
                default:
                    return .none
                }
            default:
                return .none
            }
        }  .forEach(\.path, action: \.path)
    }
}
