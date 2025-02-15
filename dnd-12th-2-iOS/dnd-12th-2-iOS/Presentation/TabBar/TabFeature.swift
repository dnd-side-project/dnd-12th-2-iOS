//
//  TabFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct TabFeature {
    struct State{
        var profile: ProfileNavigation.State = .init()
    }
    
    enum Action {
        case profile(ProfileNavigation.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.profile, action: \.profile) {
            ProfileNavigation()
        }
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
