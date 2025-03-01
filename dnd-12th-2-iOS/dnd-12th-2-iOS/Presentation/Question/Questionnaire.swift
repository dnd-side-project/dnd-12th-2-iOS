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
        var prevId = 0
        var prevStep = 0
        var questions: [
            Question] = [
                Question(questionId: 0, section: 0, title: "테스트 질문1", description: "테스트 질문", answers: [Answer(answerId: 0, content: "답변1"), Answer(answerId: 1, content: "답변2")]),
                Question(questionId: 1, section: 1, title: "테스트 질문2", description: "테스트 질문", answers: [Answer(answerId: 0, content: "답변3"), Answer(answerId: 1, content: "답변4")]),
                Question(questionId: 2, section: 2, title: "테스트 질문3", description: "테스트 질문", answers: [Answer(answerId: 0, content: "답변5"), Answer(answerId: 1, content: "답변6")])
            ]
    }
    
    enum Action{
        // 질문지 받아오기
        case fetchQuestion
        // 질문지 받아오기 응답
        case fetchQuestionResponse([Question])
        // 답변선택
        case answerTapped(answerId: Int)
        // 다음 질문으로 이동
        case incrementStep
        // 이전 질문으로 이동
        case decrementStep
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
            case let .answerTapped(answerId):
                if answerId == state.prevId {
                    state.questions[state.currentStep].answers[state.prevId].isSelected.toggle()
                } else {
                    state.questions[state.currentStep].answers[state.prevId].isSelected = false
                    state.questions[state.currentStep].answers[answerId].isSelected.toggle()
                }
                state.prevId = answerId
                return .none
            case .incrementStep:
                guard state.currentStep < state.questions.count - 1 else {
                    return .none
                }
                state.prevStep = state.currentStep
                state.currentStep += 1
                return .none
            case .decrementStep:
                guard state.currentStep > 0 else {
                    return .none
                }
                state.prevStep = state.currentStep
                state.currentStep -= 1
                return .none
            }
        }
    }
}
