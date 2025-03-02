//
//  HomeNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct HomeNavigation {
    @Reducer
    enum Path {
        case myPage(MyPage)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var isShowMenu = false
        var isShowGoalList = false
        var calendar = MakeCalendar.State()
        var fetchPlan = FetchPlan.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case path(StackActionOf<Path>)
        case goToMyPage
        case showMenu
        case showGoalList
        case calendar(MakeCalendar.Action)
        case fetchPlan(FetchPlan.Action)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.calendar, action: \.calendar) {
            MakeCalendar()
        }
        Scope(state: \.fetchPlan, action: \.fetchPlan) {
            FetchPlan()
        }
        Reduce { state, action in
            switch action {
            case .showMenu:
                state.isShowMenu = true
                return .none
            case .showGoalList:
                state.isShowGoalList = true
                return .none
            case .goToMyPage:
                state.path.append(.myPage(.init()))
                return .none
            // MARK: - MyPage
            case let .path(.element(id: id, action: .myPage(.backButtonTapped))):
                state.path.pop(from: id)
                return .none
            // MARK: - Calendar
            case let .calendar(action):
                switch action {
                    // 캘린더 날짜변경시 계획리스트 새로고침
                case let .requestDate(date):
                    return .send(.fetchPlan(.requestPlan(date)))
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
