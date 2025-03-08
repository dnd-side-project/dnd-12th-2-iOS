//
//  SetGoalFlow.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/8/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SetGoalFlow {
    @ObservableState
    struct State {
        // Tip 받아오기
        var fetchTip: FetchTip.State
        
        // 목표 또는 계획생성
        var makeType: MakeType
        
        // 현재 화면단계
        var viewFlow: ViewFlow
        
        // 목표타이틀
        var goalTitle = ""
        
        // 계획타이틀
        var planTitle = ""
        
        var isFoward = true
        
        init(makeType: MakeType = .makeGoal) {
            self.makeType = makeType
            self.viewFlow = makeType == .makeGoal ? .setGoal : .setPlan
            self.fetchTip = .init(guideType: makeType == .makeGoal ? .newGoal : .newPlan)
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchTip(FetchTip.Action)
        
        // nextButton Action
        case nextButtonTapped
        
        // backButton Action
        case backButtonTapped
        
        // 완료액션
        case completeAction
        
        // 다음액션
        case nextAction
        
        // 취소 액션
        case cancleAction
        
        // flow취소 화면에서 제거
        case requestRemoveFromStack
    }
    
    // 진행단계
    enum ViewFlow: Int, CaseIterable {
        case setGoal = 1
        case setPlan
        
        var title: String {
            switch self {
            case .setGoal:
                "지금 \n내 목표는"
            case .setPlan:
                "가장 먼저 \n해야할 일은"
            }
        }
        
        var guideType: FetchTip.GuideType {
            switch self {
            case .setGoal:
                    .newGoal
            case .setPlan:
                    .newPlan
            }
        }
        
        // flow 개수
        static var flowCount: Int {
            SetGoalFlow.ViewFlow.allCases.count
        }
    }
    
    // 생성모드
    enum MakeType {
        
        // 목표&계획 생성
        case makeGoal
        
        // 계획 생성
        case makePlan
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.fetchTip, action: \.fetchTip) {
            FetchTip()
        }
        Reduce { state, action in
            switch action {
            case .nextButtonTapped:
                return self.setNextButtonAction(&state)
            case .backButtonTapped:
                return self.setBackButtonAction(&state)
            case .completeAction:
                return .none
            case .nextAction:
                let currentIndex = state.viewFlow.rawValue
                state.viewFlow = .init(rawValue: currentIndex + 1)!
                state.fetchTip = .init(guideType: state.viewFlow.guideType)
                state.isFoward = true
                return .none
            case .cancleAction:
                let currentIndex = state.viewFlow.rawValue
                state.viewFlow = .init(rawValue: currentIndex - 1)!
                state.fetchTip = .init(guideType: state.viewFlow.guideType)
                state.isFoward = false
                return .none
            default:
                return .none
            }
        }
        ._printChanges()
    }
}

extension SetGoalFlow {
    // 현재뷰의 인덱스에 따라서 다음 액션을 호출
    func setNextButtonAction(_ state: inout State) -> Effect<Action> {
        let nextIndex = state.viewFlow.rawValue + 1
        if nextIndex > ViewFlow.flowCount {
            return .send(.completeAction)
        } else {
            return .send(.nextAction)
        }
    }
    
    // 현재뷰의 인덱스에 따라서 뒤로가기 액션을 호출
    func setBackButtonAction(_ state: inout State) -> Effect<Action> {
        let prevIndex = state.viewFlow.rawValue - 1
        if state.makeType == .makePlan {
            return .send(.requestRemoveFromStack)
        } else if prevIndex <= 0 {
            return .send(.requestRemoveFromStack)
        } else {
            return .send(.cancleAction)
        }
    }
}
