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
        let calendar: Calendar = {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone.current
            return calendar
        }()
        
        // goalType으로 예외처리
        var goalType: MakeType
        
        // 계획 설정
        var goalInfo: Goal
        
        // backButton 숨김여부
        var isShowBackButton: Bool {
            goalType != .firstGoal
        }
        
        var textFieldValidate: Bool {
            goalType != .makePlan ? !goalInfo.planTitle.isEmpty : !goalInfo.goalTitle.isEmpty && !goalInfo.planTitle.isEmpty
        }
        
        var timePickerValidate: Bool {
            goalInfo.startDate <= goalInfo.endDate
        }
        
        // 텍스트필드 유효성 검사
        var isButtonDisabled: Bool {
            !textFieldValidate || !timePickerValidate
        }
        
        var startDateTodayStr: String {
            calendar.isDate(goalInfo.startDate, inSameDayAs: .now) ? "오늘" : "내일"
        }
        
        var endDateTodayStr: String {
            calendar.isDate(goalInfo.endDate, inSameDayAs: .now) ? "오늘" : "내일"
        }
        
        var startDateStr: String {
            startDateTodayStr + " " + goalInfo.startDate.formatted("HH:mm")
        }
        
        var endDateStr: String {
            endDateTodayStr + " " + goalInfo.endDate.formatted("HH:mm")
        }
        
        // startPicker 숨김여부
        var isShowStartPicker = true
        
        // endPicker 숨김여부
        var isShowEndPicker = false
        
        init(goalType: MakeType = .makeGoal) {
            self.goalType = goalType
            self.goalInfo = .makeGoal
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
