//
//  FetchPlan.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation
import ComposableArchitecture

struct Section: Hashable {
    let key: String
    let date: String
}

@Reducer
struct FetchPlan {
    @ObservableState
    struct State {
        let goalId: Int
        var planGroup: [[Section: [Plan]]] = [[:]]
        var scrollKey = ""
        var renderKey = ""
        
        init(goalId: Int) {
            self.goalId = goalId
        }
    }
    
    enum Action {
        case requestPlan(Date)
        case fetchPlans(Date)
        case groupByStartDate([Plan])
        case responseScrollId(Date)
        case setRenderKey
    }
    
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .responseScrollId(date):
                state.scrollKey = date.formatted("yyyyMMdd")
                return .none
            case let .requestPlan(date):
                return .send(.fetchPlans(date))
            case let .fetchPlans(date):
                return  .concatenate([
                    .run { [state] send in
                        let result = try await goalClient.fetchPlans(state.goalId, date.toShortDateFormat(), 3)
                        await send(.groupByStartDate(result))
                    },
                    .send(.setRenderKey)
                ])
            case let .groupByStartDate(response):
                var groupedPlan : [Date: [Plan]] = [:]
                for plan in response {
                    // startDate부터 endDate 사이의 날짜로 key를 만든다
                    //  key의 배열에 해당 plan을 update한다
                    let startDate = plan.startDate.toDate()
                    let endDate = plan.endDate.toDate()
                    
                    var currentDate = startDate
              
                    while currentDate <= endDate {
                        groupedPlan[currentDate, default: []].append(plan)
                        
                        guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { break }
                        currentDate = nextDay
                    }
                }
                
                state.planGroup = groupedPlan.sorted { $0.key < $1.key}
                    .map { (key, value) -> Dictionary<Section, [Plan]> in
                        let date = key.formatted("MM월 dd일")
                        let uniqueKey = key.formatted("yyyyMMdd")
                        let key = Section(key: uniqueKey, date: date)
                        return [key: value]
                 }
                return .none
            case .setRenderKey:
                state.renderKey = UUID().uuidString
                return .none
            }
        }
    }
}
