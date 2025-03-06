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
    struct State {}
    
    enum Action {
        case requestPlan(Date)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .requestPlan(date):
                return .none
            }
        }
    }
}
