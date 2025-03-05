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
        
        var buttonDisabled: Bool {
            questionnaire.questions[questionnaire.currentStep].answers.filter { $0.isSelected }.isEmpty
        }
    }
    
    enum Action {
        // 첫목표설정으로 이동
        case goToFirstGoalView
        
        // 이전화면 이동
        case backButtonTapped            
        
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
        
        // 온보딩 데이터 생성
        case createOnboardingRequest
        case questionnaire(Questionnaire.Action)
    }
    
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Scope(state: \.questionnaire, action: \.questionnaire) {
            Questionnaire()
        }
        Reduce { state, action in
            switch action {
            case .createOnboardingRequest:
                return .run { [state] send in
                    try await userClient.createOnboarding(state.questionnaire.questions)
                    await send(.goToFirstGoalView)
                } catch: { error, send in
                    print(error.localizedDescription)
                }
            case .fetchQuestion:
                return .run { send in
                    let response = try await userClient.fetchQuestion()
                    await send(.fetchQuestionResponse(response))
                }
            case let .fetchQuestionResponse(questions):
                state.questionnaire = .init(question: questions)
                return .none
            case .goToNextPage:
                if state.isLastPage {
                    return .send(.createOnboardingRequest)
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
