//
//  Onboarding.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import ComposableArchitecture

@Reducer
struct Onboarding {
    @ObservableState
    struct State {
        var questionnaire = Questionnaire.State()
    }
    
    enum Action {
        case goToGoalView
        case viewAppear
        case questionnaire(Questionnaire.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.questionnaire, action: \.questionnaire) {
            Questionnaire()
        }
        Reduce { state, action in
            switch action {
            case .viewAppear:
                return .send(.questionnaire(.fetchQuestion))
            default:
                return .none
            }
        }
    }
}
