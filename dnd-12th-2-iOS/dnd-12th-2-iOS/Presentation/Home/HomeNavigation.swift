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
        case goalScreen(GoalFeature)
    }
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var goal = GoalListFeature.State()
        var plan = PlanListFeature.State()
        var isShowSheet = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case presentSheet
        case viewAppear
        case path(StackActionOf<Path>)
        case goal(GoalListFeature.Action)
        case plan(PlanListFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.goal, action: \.goal) {
            GoalListFeature()
        }
        Scope(state: \.plan, action: \.plan) {
            PlanListFeature()
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
                return .send(.goal(.fetchGoals))
            case let .goal(.goalSelected(goalId)):
                return .send(.plan(.fetchPlans(goalId: goalId, date: "2024-04-01")))
            case let .plan(.planCellTapped(planId)):
                state.path.append(.selecteScreen(.init()))
                return .none
            case .plan(.createButtonTapped):
                state.path.append(.goalScreen(.init()))
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
