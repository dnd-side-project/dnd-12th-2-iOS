//
//  FirstGoalFlow.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FirstGoalFlow {
    @ObservableState
    struct State{
        var viewFlow: GoalViewFlow = .setGoal
        var oldViewFlow: GoalViewFlow = .setGoal
        // 목표
        var goalTitle = ""
        // 계획
        var planTitle = ""
        // 시작날짜
        var startTime = Date()
        // 종료날짜
        var endTime = Date()
        var isForward: Bool {
            viewFlow.rawValue >= oldViewFlow.rawValue
        }
        // 목표 가이드
        var newGoalGuide = ""
        // 계획 가이드
        var newPlanGuide = ""
    }
    
    enum GoalViewFlow: Int {
        case setGoal
        case setPlan
        case result
        
        init?(viewIndex: Int) {
            self.init(rawValue: viewIndex)
        }
        
        var title: String {
            switch self {
            case .setGoal:
                "목표설정"
            case .setPlan:
                "계획설정"
            case .result:
                ""
            }
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        // 메인화면 이동
        case goToMain
        // 다음 스텝으로
        case goToNextStep
        // 이전 스텝으로
        case goToPrevStep
        // tip 가져오기
        case fetchTips
        // tip 가져오기 완료
        case fetchTipsResponse(Guide)
    }
    
    @Dependency(\.guideClient) var guideClient
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .goToNextStep:
                state.oldViewFlow = state.viewFlow
                state.viewFlow = .init(viewIndex: state.viewFlow.rawValue + 1)!
                return .none
            case .goToPrevStep:
                state.oldViewFlow = state.viewFlow
                state.viewFlow = .init(viewIndex: state.viewFlow.rawValue - 1)!
                return .none
            case .fetchTips:
                return .run { send in
                    let response = try await guideClient.fetchTips()
                    await send(.fetchTipsResponse(response))
                }
            case let .fetchTipsResponse(response):
                state.newGoalGuide = response.newGoalGuide
                state.newPlanGuide = response.newPlanGuide
                return .none
            default:
                return .none
            }
        }
    }
}
