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
                // 온보딩 완료
            case .loginCheck(.onboardingComplete):
                state = .loggedIn(.init())
                return .none
                // 로그인완료 - 온보딩으로 이동
            case .loginCheck(.loginComplete):
                state = .loggedOut(.init(isOnboarding: true))
                return .none
                // 로그인
            case .loginCheck(.loginNotComplete):
                state = .loggedOut(.init())
                return .none
                // 첫목표 설정 완료시
            case .loggedOut(.path(.element(id: _, action: .goal(.goToMainView)))):
                state = .loggedIn(.init())
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
