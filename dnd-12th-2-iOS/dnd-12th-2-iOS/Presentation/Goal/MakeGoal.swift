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
        var isShowBackButton: Bool {
            goalType != .firstGoal
        }
        var isShowStartPicker = true
        var isShowEndPicker = false
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
        case startPickerTapped
        case endPickerTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .startPickerTapped:
                state.isShowStartPicker = true
                state.isShowEndPicker = false
                return .none
            case .endPickerTapped:
                state.isShowStartPicker = false
                state.isShowEndPicker = true
                return .none
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
