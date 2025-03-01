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
                
        // 페이지 애니메이션
        var isNextPage: Bool {
            questionnaire.currentStep >= questionnaire.prevStep
        }
        var isLastPage: Bool {
            questionnaire.currentStep >= questionnaire.questions.count - 1
        }
    }
    
    enum Action {
        // 첫목표설정으로 이동
        case goToGoalView
        // 온보딩 완료시 결과화면이동
        case goToResultView(Onboarding.State)
        case viewAppear
        // 다음질문지로 이동
        case goToNextPage
        // 이전질문지로 이동
        case goToPrevPage
        // 답변선택
        case answerTapped(answerId: Int)
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
            case .goToNextPage:
                if state.isLastPage {
                    return .send(.goToResultView(state))
                } else {
                    return .send(.questionnaire(.incrementStep))
                }
            case .goToPrevPage:
                return .send(.questionnaire(.decrementStep))
            case let .answerTapped(answerId):
                return .send(.questionnaire(.answerTapped(answerId: answerId)))
            default:
                return .none
            }
        }
    }
}
