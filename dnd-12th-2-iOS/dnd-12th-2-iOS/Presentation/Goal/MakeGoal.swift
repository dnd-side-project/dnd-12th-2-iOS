//
//  MakeGoal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct MakeGoal {
    @ObservableState
    struct State {
        var goalType: MakeType
        
        init(goalType: MakeType = .makeGoal) {
            self.goalType = goalType
        }
    }
    
    enum MakeType {
        // 첫계획 생성
        case firstGoal
        // 목표 생성
        case makeGoal
        // 계획 생성
        case makePlan
    }
    
    enum Action {
        case completeButtonTapped
        case goToMainView
        case goToCompleteView
        case backButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .completeButtonTapped:
                switch state.goalType {
                case .firstGoal:
                    return .send(.goToCompleteView)
                case .makeGoal:
                    return .send(.backButtonTapped)
                case .makePlan:
                    return .send(.backButtonTapped)
                }
            default:
                return .none
            }
        }
    }
}
