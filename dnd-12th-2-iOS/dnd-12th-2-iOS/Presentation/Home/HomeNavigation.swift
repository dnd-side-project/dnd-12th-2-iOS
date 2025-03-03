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
        case GoalSetting(MakeGoal)
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
        // 라우팅액션
        case path(StackActionOf<Path>)
        
        // 마이페이지 이동
        case goToMyPage
        
        // 목표 설정
        case goToGoalSetting
        
        // 목표 계획 설정
        case goToGoalSettingWithPlan
        
        // 메뉴 숨김여부
        case showMenu
        
        // 목표리스트 숨김여부
        case showGoalList
        
        case hideMenu
        
        case hideGoalList
        
        // 캘린더
        case calendar(MakeCalendar.Action)
        
        // 목표리스트
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
            case .hideMenu:
                state.isShowMenu = false
                return .none
            case .showMenu:
                state.isShowMenu = true
                return .none
            case .hideGoalList:
                state.isShowGoalList = false
                return .none
            case .showGoalList:
                state.isShowGoalList = true
                return .none
                // MARK: - MyPage
            case .goToMyPage:
                state.path.append(.myPage(.init()))
                return .none
            case let .path(.element(id: id, action: .myPage(.backButtonTapped))):
                state.path.pop(from: id)
                return .none
                // MARK: - GoalSetting
            case .goToGoalSetting:
                state.path.append(.GoalSetting(.init(goalType: .makePlan)))
                return .none
            case .goToGoalSettingWithPlan:
                state.path.append(.GoalSetting(.init(goalType: .makeGoal)))
                return .send(.hideMenu)
            case let .path(.element(id: id, action: .GoalSetting(.backButtonTapped))):
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
