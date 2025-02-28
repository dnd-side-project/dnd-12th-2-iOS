//
//  MyPage.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct MyPage {
    struct State {}
    
    enum Action {
        case logoutButtonTapped
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

