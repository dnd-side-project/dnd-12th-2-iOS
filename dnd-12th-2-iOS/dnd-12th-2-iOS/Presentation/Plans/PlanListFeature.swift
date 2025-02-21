//
//  PlanListFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PlanListFeature {
    @ObservableState
    struct State {
        var plans: [PlanGroup] = []
        var historyCount: Int {
            plans.flatMap{ $0.plans }.count
        }
    }
    
    enum Action {
        case fetchPlans(goalId: Int, date: String)
        case fetchPlansResponse([PlanGroup])
        
        case planCellTapped(planId: Int)
        case createButtonTapped
    }
    
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fetchPlans(goalId, date):                
                return .run { send in
                    let result = try await goalClient.fetchPlans(goalId, date)
                    await send(.fetchPlansResponse(result))
                }
            case let .fetchPlansResponse(response):
                state.plans = response
                return .none
            default:
                return .none
            }
        }
    }    
}
