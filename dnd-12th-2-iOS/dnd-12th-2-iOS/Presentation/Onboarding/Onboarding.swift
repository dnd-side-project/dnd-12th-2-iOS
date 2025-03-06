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
        
        var isFirstPage: Bool {
            questionnaire.currentStep == 0
        }
        
        var buttonDisabled: Bool {
            questionnaire.questions[questionnaire.currentStep].answers.filter { $0.isSelected }.isEmpty
        }
    }
    
    enum Action {
        // 설문페이지
        case questionnaire(Questionnaire.Action)
        
        // 첫목표설정으로 이동
        case goToFirstGoalView
        
        // 이전화면 이동
        case backButtonTapped
        
        // 이전질문지로 이동
        case goToPrevPage
        
        // 질문지 받아오기
        case fetchQuestion
        
        // 질문지 받아오기 응답
        case fetchQuestionResponse([Question])
        
        // 온보딩 데이터 생성
        case createOnboardingRequest
    }
    
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Scope(state: \.questionnaire, action: \.questionnaire) {
            Questionnaire()
        }
        Reduce { state, action in
            switch action {
            case .questionnaire(.questionCompleted):
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
            case .goToPrevPage:
                return .send(.questionnaire(.decrementStep))
            default:
                return .none
            }
        }
    }
}
