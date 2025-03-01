//
//  HomeNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct HomeNavigation {
    @Reducer
    enum Path {
        case myPage(MyPage)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case goToMyPage
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .goToMyPage:
                state.path.append(.myPage(.init()))
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
