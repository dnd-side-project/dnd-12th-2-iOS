//
//  HomeNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct HomeNavigation {
    
    @ObservableState
    struct State {
        var isShowMenu = false
        var isShowGoalList = false
        var calendar: MakeCalendar.State
        var fetchPlan: FetchPlan.State
        let goalTitle: String
        let goalId: Int
        
        init(goalId: Int, goalTitle: String) {
            self.goalId = goalId
            self.goalTitle = goalTitle
            self.calendar = .init(goalId: goalId)
            self.fetchPlan = .init(goalId: goalId)
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        // 메뉴 숨김여부
        case showMenu
                
        case hideMenu
        
        case backButtonTapped
        
        case goToArchiveGoal
        
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
                // MARK: - Calendar
            case let .calendar(action):
                switch action {
                    // 캘린더 날짜변경시 계획리스트 새로고침
                case let .requestScrollId(date):
                    return .send(.fetchPlan(.responseScrollId(date)))
                case let .requestDate(date):
                    return .send(.fetchPlan(.requestPlan(date)))
                default:
                    return .none
                }
            default:
                return .none
            }
        }    
    }
}
