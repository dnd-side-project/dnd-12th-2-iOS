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
        case loggedIn(MainNavigation.State)
        case loggedOut(LoginNavigation.State)
        case loginCheck(LoginCheck.State)
        
        init() {
            self = .loginCheck(.init())
        }
    }
    
    enum Action {
        case loggedIn(MainNavigation.Action)
        case loggedOut(LoginNavigation.Action)
        case loginCheck(LoginCheck.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                // MARK: - LoginCheck
                // 온보딩 완료
            case .loginCheck(.onboardingComplete):
                state = .loggedIn(.init())
                return .none
                // 로그인완료
            case .loginCheck(.loginComplete):
                state = .loggedOut(.init(isOnboarding: true))
                return .none
                // 로그인
            case .loginCheck(.loginNotComplete):
                state = .loggedOut(.init())
                return .none
                // MARK: - LoggedIn
                // 마이페이지 로그아웃시
            case .loggedIn(.path(.element(id: _, action: .myPage(.logoutComplete)))):
                state = .loggedOut(.init())
                return .none
                // MARK: - LoggedOut
                // 온보딩 완료된경우 메인으로 이동
            case .loggedOut(.goToMain):
                state = .loggedIn(.init())
                return .none
                // 온보딩 미완료시 온보딩으로 이동
            case .loggedOut(.goToOnboarding):
                state = .loggedOut(.init(isOnboarding: true))
                return .none
            default:
                return .none
            }
        }
        .ifCaseLet(\.loggedOut, action: \.loggedOut) {
            LoginNavigation()
        }
        .ifCaseLet(\.loggedIn, action: \.loggedIn) {
            MainNavigation()
        }
        .ifCaseLet(\.loginCheck, action: \.loginCheck) {
            LoginCheck()
        }
    }
}
