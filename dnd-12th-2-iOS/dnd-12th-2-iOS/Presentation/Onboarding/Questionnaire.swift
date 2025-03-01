//
//  Questionnaire.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/1/25.
//

import ComposableArchitecture

@Reducer
struct Questionnaire {
    @ObservableState
    struct State {
        var currentStep = 0
        var prevStep = 0
        var questions: [Question] = [Question(questionId: 0, section: 0, title: "", description: "", answers: [])]
    }
    
    enum Action{
        // 질문지 받아오기
        case fetchQuestion
        // 질문지 받아오기 응답
        case fetchQuestionResponse([Question])
    }
    
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchQuestion:
                return .run { send in
                    let response = try await userClient.fetchQuestion()
                    await send(.fetchQuestionResponse(response))
                }
            case let .fetchQuestionResponse(questions):
                state.questions = questions
                return .none
            }
        }
    }
}
