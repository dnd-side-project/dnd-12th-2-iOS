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
        
        var isLastPage: Bool {
            questionnaire.currentStep >= questionnaire.questions.count - 1
        }
        
        var isFirstPage: Bool {
            questionnaire.currentStep == 0
        }
    }
    
    enum Action {
        // 첫목표설정으로 이동
        case goToGoalView
        
        // 온보딩 완료시 결과화면이동
        case goToResultView(Onboarding.State)
        
        // 이전화면 이동
        case backButtonTapped
        
        case viewAppear
        
        // 다음질문지로 이동
        case goToNextPage
        
        // 이전질문지로 이동
        case goToPrevPage
        
        // 답변선택
        case answerTapped(answerId: Int)
        
        // 질문지 받아오기
        case fetchQuestion
        
        // 질문지 받아오기 응답
        case fetchQuestionResponse([Question])
        case questionnaire(Questionnaire.Action)
    }
    
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Scope(state: \.questionnaire, action: \.questionnaire) {
            Questionnaire()
        }
        Reduce { state, action in
            switch action {
            case .fetchQuestion:
                return .run { send in
                    let response = try await userClient.fetchQuestion()
                    await send(.fetchQuestionResponse(response))
                }
            case let .fetchQuestionResponse(questions):
                state.questionnaire = .init(question: questions)
                return .none
            case .viewAppear:
                return .send(.fetchQuestion)
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
