//
//  MakeGoal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MakeGoal {
    @ObservableState
    struct State {
        // goalType으로 예외처리
        var goalType: MakeType
        
        // backButton 숨김여부
        var isShowBackButton: Bool {
            goalType != .firstGoal
        }
        
        // 텍스트필드 유효성 검사
        var isButtonDisabled: Bool {
            goalType != .makePlan ? goalTitle.isEmpty || planTitle.isEmpty : planTitle.isEmpty
        }
        
        var startDateTodayStr: String {
            Calendar.current.isDateInToday(startDate) ? "오늘" : "내일"
        }
        
        var endDateTodayStr: String {
            Calendar.current.isDateInToday(endDate) ? "오늘" : "내일"
        }
        
        var startDateStr: String {
            startDateTodayStr + " " + startDate.formatted("HH:mm")
        }
        
        var endDateStr: String {
            endDateTodayStr + " " + endDate.formatted("HH:mm")
        }
        
        // startPicker 숨김여부
        var isShowStartPicker = true
        
        // endPicker 숨김여부
        var isShowEndPicker = false
        
        // 목표텍스트
        var goalTitle = ""
        
        // 계획텍스트
        var planTitle = ""
        
        // 시작날짜
        var startDate = Date()
        
        // 종료날짜
        var endDate = Date()
        
        init(goalType: MakeType = .makeGoal) {
            self.goalType = goalType
        }
    }
    
    enum MakeType {
        // 첫계획 생성
        case firstGoal
        // 목표 생성
        case makeGoal
        // 계획 생성
        case makePlan
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        // 완료버튼
        case completeButtonTapped
        
        // 메인뷰로 이동
        case goToMainView
        
        // 첫목표 설정 완료시
        case goToCompleteView
        
        // 뒤로가기
        case backButtonTapped
        
        // startPickerTapped
        case startPickerTapped
        
        // startPickerTapped
        case endPickerTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .startPickerTapped:
                state.isShowStartPicker = true
                state.isShowEndPicker = false
                return .none
            case .endPickerTapped:
                state.isShowStartPicker = false
                state.isShowEndPicker = true
                return .none
            case .completeButtonTapped:
                switch state.goalType {
                case .firstGoal:
                    return .send(.goToCompleteView)
                case .makeGoal:
                    return .send(.backButtonTapped)
                case .makePlan:
                    return .send(.backButtonTapped)
                }
            default:
                return .none
            }
        }
    }
}
