//
//  Navigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct Navigation {
    enum State {
        case loggedIn(HomeNavigation.State)
        case loggedOut(LoginNavigation.State)
        case loginCheck(LoginCheck.State)
        
        init() {
            self = .loginCheck(.init())
        }
    }
    
    enum Action {
        case loggedIn(HomeNavigation.Action)
        case loggedOut(LoginNavigation.Action)
        case loginCheck(LoginCheck.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loginCheck(.onboardingComplete):
                state = .loggedIn(.init())
                return .none
            case .loginCheck(.loginComplete):
                state = .loggedOut(.init(isOnboarding: true))
                return .none
            case .loginCheck(.loginNotComplete):
                state = .loggedOut(.init())
                return .none
            default:
                return .none
            }
        }
        .ifCaseLet(\.loggedOut, action: \.loggedOut) {
            LoginNavigation()
        }
        .ifCaseLet(\.loggedIn, action: \.loggedIn) {
            HomeNavigation()
        }
        .ifCaseLet(\.loginCheck, action: \.loginCheck) {
            LoginCheck()
        }
    }
}
