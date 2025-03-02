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
        var isShowMenu = false
        var isShowGoalList = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case path(StackActionOf<Path>)
        case goToMyPage
        case showMenu
        case showGoalList
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .showMenu:
                state.isShowMenu = true
                return .none
            case .showGoalList:
                state.isShowGoalList = true
                return .none
            case .goToMyPage:
                state.path.append(.myPage(.init()))
                return .none
            case let .path(.element(id: id, action: .myPage(.backButtonTapped))):
                state.path.pop(from: id)
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
