//
//  OnboardingFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//

import ComposableArchitecture

@Reducer
struct OnboardingFeature {
    @ObservableState
    struct State: Equatable {
        var currentStep = 0
        var prevStep = 0
        var isFirstPage: Bool {
            currentStep == 0
        }
        var isLastPage: Bool {
            questions.count <= currentStep + 1
        }
        var isNextPage: Bool {
            currentStep >= prevStep
        }
        var isSelected: Bool {
            questions[currentStep].answers.filter { $0.isSelected }.count > 0 || questions.count - 1 == currentStep
        }
        var questions: [Question] = [Question(questionId: 0, section: 0, title: "", description: "", answers: []),
                                     Question(questionId: 1, section: 1, title: "", description: "", answers: [])]
                
    }
    
    enum Action {
        case goToPage(Int)
        case answerTapped(Int)
        case completeButtonTapped
        
        case fetchOnboardingRequest
        case fetchOnboardingResponse([Question])
        
        case createOnboardingRequest
    }
    
    @Dependency(\.userClient) var userClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .createOnboardingRequest:
                return .run { [state] send in
                    var questions = state.questions
                    questions.removeLast()
                    try await userClient.createOnboarding(questions)
                } catch: { error, send in
                }
            case .fetchOnboardingRequest:
                return .run { send in
                    let response = try await userClient.fetchOnboarding()
                    await send(.fetchOnboardingResponse(response))
                }
            case let .fetchOnboardingResponse(response):
                let dummyQuestion = Question(questionId: response.count + 1,
                                             section: response.count + 1,
                                             title: "목표 달성, \n알림 하나로 더 가까워집니다!",
                                             description: "즉각적인 행동이 목표 달성률을 30% 높인다는 연구 \n결과가 있습니다. 알림으로 중요한 순간을 놓치지 마세요!",
                                             answers: [])
                
                var questions = response
                questions.append(dummyQuestion)
                state.questions = questions
                return .none
            case let .goToPage(step):
                if state.isLastPage && step >= state.currentStep {
                    return .send(.createOnboardingRequest)
                } else {
                    state.prevStep = state.currentStep
                    state.currentStep = step
                    return .none
                }
                
            case let .answerTapped(answerId):
                state.questions[state.currentStep].answers[answerId].isSelected.toggle()
                return .none
            case .completeButtonTapped:
                return .none
            }
        }
    }
}
