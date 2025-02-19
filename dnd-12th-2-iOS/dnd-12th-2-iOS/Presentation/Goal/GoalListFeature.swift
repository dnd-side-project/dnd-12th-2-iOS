//
//  GoalListFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import ComposableArchitecture

@Reducer
struct GoalListFeature {
    @ObservableState
    struct State: Equatable {
        var goalList: [Goal] = []
        var selectedGoal: Goal = Goal(goalId: 0, title: "", successCount: 0, failureCount: 0, totalCount: 0)
    }
    
    enum Action {
        case fetchGoals
        case fetchGoalResponse([Goal])
        case cardTapped(goalId: Int)
        case goalSelected(goalId: Int)
    }
    
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchGoals:
                return .run { send in
                    let result = try await goalClient.fetchGoals()
                    await send(.fetchGoalResponse(result))
                }
            case let .fetchGoalResponse(response):
                state.goalList = response
                state.selectedGoal = response.first ?? state.selectedGoal                
                return .send(.goalSelected(goalId: state.selectedGoal.goalId))
            case let .cardTapped(goalId):
                state.selectedGoal = state.goalList.first(where: {$0.goalId == goalId}) ?? state.selectedGoal
                return .send(.goalSelected(goalId: goalId))
            default:
                return .none
            }
        }
    }
}
