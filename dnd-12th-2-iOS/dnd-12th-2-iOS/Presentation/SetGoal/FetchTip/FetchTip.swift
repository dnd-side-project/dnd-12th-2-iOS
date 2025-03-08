//
//  FetchTip.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/8/25.
//

import ComposableArchitecture

@Reducer
struct FetchTip {
    @ObservableState
    struct State {
        // 상황에 맞는 Tip조회
        var guideType: GuideType
                
        var guideString = ""
        
        init(guideType: GuideType = .newGoal) {
            self.guideType = guideType
        }
    }
    
    enum GuideType {
        // 새로운 목표 설정
        case newGoal
        
        // 새로운 계획 설정
        case newPlan
        
        // 타입에따른 pathParameter
        var path: String {
            switch self {
            case .newGoal:
                return "new-goal"
            case .newPlan:
                return "new-plan"
            }
        }
    }
    
    enum Action {
        case fetchTip
        case fetchTipResponse(String)
    }
    
    @Dependency(\.guideClient) var guideClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchTip:
                return .run { [state] send in
                    let result = try await guideClient.fetchTip(state.guideType.path)
                    await send(.fetchTipResponse(result))
                }
            case let .fetchTipResponse(response):
                state.guideString = response
                return .none
            }
        }
    }
}
