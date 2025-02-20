//
//  CaledarFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//


import ComposableArchitecture

@Reducer
struct CalendarFeature {
    struct State: Equatable {}
    
    enum Action {
        
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
