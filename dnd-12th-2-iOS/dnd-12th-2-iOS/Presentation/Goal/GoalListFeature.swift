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
    }
    
    enum Action {
        case fetchGoals
        case fetchGoalResponse([Goal])
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
                return .none
            default:
                return .none
            }
        }
    }
}
