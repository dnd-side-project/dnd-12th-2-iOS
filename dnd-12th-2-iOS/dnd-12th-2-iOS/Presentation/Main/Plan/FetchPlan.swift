//
//  FetchPlan.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FetchPlan {
    @ObservableState
    struct State {
        let goalId: Int
        var planGroup: [String: [Plan]] = [:]
        var scrollKey = ""
        
        init(goalId: Int) {
            self.goalId = goalId
        }
    }
    
    enum Action {
        case requestPlan(Date)
        case fetchPlans(Date)
        case fetchPlanResponse([Plan])
        case responseScrollId(Date)
    }
    
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .responseScrollId(date):
                state.scrollKey = date.toShortDateFormat()
                return .none
            case let .requestPlan(date):
                return .send(.fetchPlans(date))
            case let .fetchPlans(date):
                return  .run { [state] send in
                    let result = try await goalClient.fetchPlans(state.goalId, date.toShortDateFormat(), 3)
                    await send(.fetchPlanResponse(result))
                } catch: { error, send in
                    print(error.localizedDescription)
                }
            case let .fetchPlanResponse(response):
                return .none
            }
        }
    }
}
