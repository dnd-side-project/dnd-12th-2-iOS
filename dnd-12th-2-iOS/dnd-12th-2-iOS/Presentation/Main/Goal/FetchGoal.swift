//
//  FetchGoal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/6/25.
//

import ComposableArchitecture

@Reducer
struct FetchGoal {
    @ObservableState
    struct State {
        var goalList: [Goal] = []
    }
    
    enum Action{
        case fetchGoals
        case fetchGoalResponse([Goal])
        case cellTapped(Goal)
    }
    
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchGoals:
                return .run { send in
                    let result = try await goalClient.fetchGoal()
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
