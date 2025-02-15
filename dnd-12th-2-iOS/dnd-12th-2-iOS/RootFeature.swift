//
//  RootFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
    enum State {
        case loggedIn(TabFeature.State)
        case loggedOut(LoginNavigation.State)
        case loginCheck(SplashFeature.State)
        
        init() {
            self = .loginCheck(.init())
        }
    }
    
    enum Action {
        case loggedOut(LoginNavigation.Action)
        case loggedIn(TabFeature.Action)
        case loginCheck(SplashFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loggedOut(.goToMain):
                state = .loggedIn(.init())
                return .none
            case .loggedIn(.profile(.logoutButtonTapped)):
                state = .loggedOut(.init())
                return .none
            case let .loginCheck(.loginCompleted(isLogin)):
                if isLogin {
                    state = .loggedIn(.init())
                } else {
                    state = .loggedOut(.init())
                }
                return .none
            default:
                return .none
            }
        }
        .ifCaseLet(/State.loggedOut, action: /Action.loggedOut) {
            LoginNavigation()
        }
        .ifCaseLet(/State.loggedIn, action: /Action.loggedIn) {
            TabFeature()
        }
        .ifCaseLet(/State.loginCheck, action: /Action.loginCheck) {
            SplashFeature()
        }
    }
}
