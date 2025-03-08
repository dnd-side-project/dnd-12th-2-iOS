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
    // MARK: - State
    @ObservableState
    struct State {
        // Tip 받아오기
        var fetchTip: FetchTip.State
        
        // 목표 또는 계획생성
        var makeType: MakeType
        
        // 현재 화면단계
        var viewFlow: ViewFlow
        
        var goalId = 0
        
        // 목표타이틀
        var goalTitle = ""
        
        // 계획타이틀
        var planTitle = ""
        
        // 시작 날짜
        var startDate = Date()
        
        // 종료날짜
        var endDate = Date()
        
        var isFoward = true
        
        /// 새로운 목표생성
        init() {
            self.makeType = .makeGoal
            self.viewFlow = .setGoal
            self.fetchTip = .init(guideType: .newGoal)
        }
        
        /// 새로운 계획생성(goalID 필수)
        /// - Parameter goalId: 계획을 생성할 목표의 goalID
        init(goalId: Int) {
            self.goalId = goalId
            self.makeType = .makePlan
            self.viewFlow = .setPlan
            self.fetchTip = .init(guideType: .newPlan)
        }
    }
    
    // MARK: - Action
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
        
        // 계획생성
        case requestMakePlan
        
        // 목표생성
        case requestMakeGoal
    }
    
    // MARK: - ViewFlow
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
        
        var guideType: FetchTip.GuideType? {
            switch self {
            case .setGoal:
                return .newGoal
            case .setPlan:
                return .newPlan
            }
        }
        
        // flow 개수
        static var flowCount: Int {
            SetGoalFlow.ViewFlow.allCases.count
        }
    }
    
    // MARK: - Make Type
    enum MakeType {
        
        // 목표&계획 생성
        case makeGoal
        
        // 계획 생성
        case makePlan
    }
    
    // MARK: - Dependencies
    @Dependency(\.goalClient) var goalClient
    
    // MARK: - Reducer
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
                return self.setCompleteAction(&state)
            case .nextAction:
                let currentIndex = state.viewFlow.rawValue
                state.viewFlow = .init(rawValue: currentIndex + 1)!
                state.isFoward = true
                if let guideType = state.viewFlow.guideType {
                    state.fetchTip = .init(guideType: guideType)
                }
                return .none
            case .cancleAction:
                let currentIndex = state.viewFlow.rawValue
                state.viewFlow = .init(rawValue: currentIndex - 1)!
                state.isFoward = false
                if let guideType = state.viewFlow.guideType {
                    state.fetchTip = .init(guideType: guideType)
                }
                return .none
                // API
            case .requestMakePlan:
                return .run { [state] send in
                    try await goalClient.makePlan(state.goalId, .init(title: state.planTitle, startDate: state.startDate, endDate: state.endDate))
                    await send(.requestRemoveFromStack)
                }
            case .requestMakeGoal:
                return .run { send in
                    
                }
            default:
                return .none
            }
        }
        ._printChanges()
    }
}

// MARK: - Helper
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
    
    func setCompleteAction(_ state: inout State) -> Effect<Action>  {
        switch state.makeType {
        case .makeGoal:
            return .send(.requestMakeGoal)
        case .makePlan:
            return .send(.requestMakePlan)
        }
    }
}
