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
        case setGoal(SetGoalFlow)
        case myPage(MyPage)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var fetchGoal = FetchGoal.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case path(StackActionOf<Path>)
        // 목표설정으로 이동
        case goToSetGoalView
        // 마이페이지로 이동
        case goToMyPage
        case fetchGoal(FetchGoal.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.fetchGoal, action: \.fetchGoal) {
            FetchGoal()
        }
        Reduce { state, action in
            switch action {
                // MARK: - MainView
            case .goToSetGoalView:
                state.path.append(.setGoal(.init()))
                return .none
            case .goToMyPage:
                state.path.append(.myPage(.init()))
                return .none
                // goalID 넘겨주고 상세화면 이동
            case let .fetchGoal(.cellTapped(goalInfo)):
                state.path.append(.home(.init(goalId: goalInfo.goalId, goalTitle: goalInfo.title)))
                return .none
                // MARK: - Flow
            case let .path(action):
                switch action {
                case let .element(id: id, action: .myPage(.backButtonTapped)):
                    state.path.pop(from: id)
                    return .none
                case let .element(id: id, action: .home(.backButtonTapped)):
                    state.path.pop(from: id)
                    return .none
                case let .element(id: id, action: .setGoal(.requestRemoveFromStack)):
                    state.path.pop(from: id)
                    return .none
                    // TODO: - 목표달성 연결
                case .element(id: _, action: .home(.goToArchiveGoal)):
                    // 목표달성 경로 추가
                    return .none
                case .element(id: _, action: .home(.goToSetPlan)):
                    state.path.append(.setGoal(.init(makeType: .makeGoal)))
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
