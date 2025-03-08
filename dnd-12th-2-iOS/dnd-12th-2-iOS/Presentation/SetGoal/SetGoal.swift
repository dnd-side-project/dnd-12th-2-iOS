//
//  SetGoal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import ComposableArchitecture

@Reducer
struct SetGoal {
    struct State {
        var fetchTip = FetchTip.State()
    }
    
    enum Action {
        case fetchTip(FetchTip.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.fetchTip, action: \.fetchTip) {
            FetchTip()
        }
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
