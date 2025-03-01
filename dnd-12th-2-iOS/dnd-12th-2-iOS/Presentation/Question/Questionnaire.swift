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
        var questions: [Question] = []
        
        init(question: [Question] = [Question(questionId: 0, section: 0, title: "", description: "", answers: [Answer(answerId: 0, content: ""), Answer(answerId: 1, content: "")])]) {
            self.questions = question
        }
    }
    
    enum Action{
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
            case let .answerTapped(answerId):
                if answerId == state.prevId {
                    state.questions[state.currentStep].answers[state.prevId].isSelected.toggle()
                } else {
                    state.questions[state.currentStep].answers[state.prevId].isSelected = false
                    state.questions[state.currentStep].answers[answerId].isSelected = true
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
