//
//  LoginNavigation.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct LoginNavigation {
    @Reducer
    enum Path {
        case onboarding(Onboarding)
        case complete(Onboarding)
        case goal(MakeGoal)
        case goalComplete(MakeGoal)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        
        init(isOnboarding: Bool = false) {
            if isOnboarding {
                self.path.append(.onboarding(.init()))
            }
        }
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case loginButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case let .element(id: _, action: .onboarding(.goToResultView(onboarding))):
                    state.path.append(.complete(onboarding))
                    return .none
                case .element(id: _, action: .complete(.goToGoalView)):
                    state.path.append(.goal(.init(goalType: .firstGoal)))
                    return .none
                case .element(id: _, action: .goal(.goToCompleteView)):
                    state.path.append(.goalComplete(.init()))
                    return .none
                case let .element(id: id, action: .complete(.backButtonTapped)):
                    state.path.pop(from: id)
                    return .none
                default:
                    return .none
                }
            case .loginButtonTapped:
                // TODO: 로그인한 유저 온보딩 완료여부 확인 처리
                state.path.append(.onboarding(.init()))
                return .none
            }
        }.forEach(\.path, action: \.path)
    }
}
