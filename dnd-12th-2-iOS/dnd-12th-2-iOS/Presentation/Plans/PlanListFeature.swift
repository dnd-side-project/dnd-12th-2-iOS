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
    }
    
    enum Action {
        case fetchPlans(goalId: Int, date: String)
        case fetchPlansResponse([Plan])
        
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
                state.plans = groupPlansByStartDate(response)
                return .none
            default:
                return .none
            }
        }
    }
    
    func groupPlansByStartDate(_ plans: [Plan]) -> [PlanGroup] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        var groupedPlans: [Date: [Plan]] = [:]
        
        for plan in plans {
            guard let date = dateFormatter.date(from: plan.startDate) else { continue }
            groupedPlans[date, default: []].append(plan)
        }
        
        return groupedPlans
            .sorted { $0.key < $1.key } // startDate 기준 정렬
            .map { PlanGroup(startDate: $0.key, plans: $0.value) }
    }
}
