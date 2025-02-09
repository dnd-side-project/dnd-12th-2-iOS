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
        let questions: [Question] = [
            Question(section: 0,
                         title: "어떤 목표 분야에 \n가장 관심이 있으신가요?",
                         description: "",                         
                         answers: [Answer(question: "건강/운동"),
                                     Answer(question: "학업/자기개발"),
                                     Answer(question: "커리어/직업"),
                                     Answer(question: "취미/여가"),
                                     Answer(question: "기타")]),
            Question(section: 1,
                         title: "계획을 세울 때 \n어떤 방식을 선호하시나요?",
                         description: "당신의 스타일에 딱 맞는 실행 전략을 찾아드릴게요!",
                         answers: [ Answer(question: "구체적인 단계별 계획"),
                                      Answer(question: "큰 방향성만 잡기"),
                                      Answer(question: "유연하게 접근하기"),
                                      Answer(question: "체크리스트 활용"),
                                      Answer(question: "기타")]),
            Question(section: 2,
                         title: "계획 설정 시 어떤 부분에서 \n가장 어려움을 느끼시나요?",
                         description: "당신의 고민에 맞춘 개선 팁을 제공해드릴게요!",
                         answers: [ Answer(question: "목표 구체화"),
                                      Answer(question: "시간 관리"),
                                      Answer(question: "우선순위 결정"),
                                      Answer(question: "실행 동기 부족"),
                                      Answer(question: "기타")]),
        ]
    }
    enum Action {
        case goToPage(Int)
        
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .goToPage(step):
                state.prevStep = state.currentStep
                state.currentStep = step                
                return .none
            }
        }
    }
}
