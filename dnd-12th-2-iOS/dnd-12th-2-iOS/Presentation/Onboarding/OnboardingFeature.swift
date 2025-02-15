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
        var questions: [Question] = [
            Question(section: 0,
                     title: "어떤 목표 분야에 \n가장 관심이 있으신가요?",
                     description: "",
                     answers: [Answer(text: "건강/운동"),
                               Answer(text: "학업/자기개발"),
                               Answer(text: "커리어/직업"),
                               Answer(text: "취미/여가"),
                               Answer(text: "기타")]),
            Question(section: 1,
                     title: "계획을 세울 때 \n어떤 방식을 선호하시나요?",
                     description: "당신의 스타일에 딱 맞는 실행 전략을 찾아드릴게요!",
                     answers: [ Answer(text: "구체적인 단계별 계획"),
                                Answer(text: "큰 방향성만 잡기"),
                                Answer(text: "유연하게 접근하기"),
                                Answer(text: "체크리스트 활용"),
                                Answer(text: "기타")]),
            Question(section: 2,
                     title: "계획 설정 시 어떤 부분에서 \n가장 어려움을 느끼시나요?",
                     description: "당신의 고민에 맞춘 개선 팁을 제공해드릴게요!",
                     answers: [Answer(text: "목표 구체화"),
                               Answer(text: "시간 관리"),
                               Answer(text: "우선순위 결정"),
                               Answer(text: "실행 동기 부족"),
                               Answer(text: "기타")]),
            Question(section: 3,
                     title: "목표 달성, \n알림 하나로 더 가까워집니다!",
                     description: "즉각적인 행동이 목표 달성률을 30% 높인다는 연구 결과\n가 있습니다. 알림으로 중요한 순간을 놓치지 마세요!",
                     answers: []),
        ]
    }
    
    enum Action {
        case goToPage(Int)
        case answerTapped(Int)
        case completeButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .goToPage(step):
                if state.isLastPage && step >= state.currentStep {                    
                    return .send(.completeButtonTapped)
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
