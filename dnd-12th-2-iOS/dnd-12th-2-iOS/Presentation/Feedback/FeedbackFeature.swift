//
//  FeedbackFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct FeedbackFeature {
    struct State: Equatable {}
    
    enum Action {
        case goToComplete
        case goToResult
        case completeButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

