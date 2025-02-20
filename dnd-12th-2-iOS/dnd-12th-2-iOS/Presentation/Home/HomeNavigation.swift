//
//  HomeNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//
import Foundation
import ComposableArchitecture

@Reducer
struct HomeNavigation {
    @Reducer
    enum Path {
        case selecteScreen(FeedbackFeature)
        case completeScreen(FeedbackFeature)
        case resultScreen(FeedbackFeature)
        case goalScreen(GoalFeature)
    }
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var goal = GoalListFeature.State()
        var plan = PlanListFeature.State()
        var calendar = CalendarFeature.State()
        var isShowSheet = false
        var hasAppeared = false
    }
    
    enum Action: BindableAction {
        // binding
        case binding(BindingAction<State>)
        
        // action
        case presentSheet
        case viewAppear
        case createButtonTapped
        
        // navigation
        case path(StackActionOf<Path>)
        
        // features
        case goal(GoalListFeature.Action)
        case plan(PlanListFeature.Action)
        case calendar(CalendarFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.goal, action: \.goal) {
            GoalListFeature()
        }
        Scope(state: \.plan, action: \.plan) {
            PlanListFeature()
        }
        Scope(state: \.calendar, action: \.calendar) {
            CalendarFeature()
        }
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .presentSheet:
                state.isShowSheet = true
                return .none
            case let .goal(.cardTapped(goalId)):
                state.isShowSheet = false
                return .none
            case .viewAppear:
                if state.hasAppeared {
                    return .none
                } else {
                    state.hasAppeared = true
                    return .send(.goal(.fetchGoals))
                }
            // 날짜 선택시 게획리스트 받아오기
            case let .calendar(.dayCellTapped(goalId, date)):
                return .send(.plan(.fetchPlans(goalId: goalId, date: date)))
            // 캘린더 날짜변경시 계획리스트 받아오기
//            case let .calendar(.dayChanged(goalId, date)):
//                return .send(.plan(.fetchPlans(goalId: goalId, date: date)))
            // 날짜에 따른 계획리스트 조회
            // 캘린더의 첫번째 날짜를 받아와서 보내줘야함
            case let .goal(.goalSelected(goalId)):
                let startWeek = Date().startOfWeek()?.toShortDateFormat() ?? ""
                return .merge([
                    .send(.calendar(.fetchStatistics(goalId: goalId))),
                    .send(.plan(.fetchPlans(goalId: goalId, date: startWeek)))
                ])
            case let .plan(.planCellTapped(planId)):
                state.path.append(.selecteScreen(.init()))
                return .none
            case .createButtonTapped:
                state.path.append(.goalScreen(.init()))
                return .none
                // Navigation
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
                case .element(id: _, action: .goalScreen(.completeButtonTapped)):
                    state.path.removeAll()
                    return .none
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        ._printChanges()
    }
}
