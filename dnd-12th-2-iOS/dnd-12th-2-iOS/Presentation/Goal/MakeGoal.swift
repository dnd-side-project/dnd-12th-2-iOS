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
        
        // 목표 가이드
        var newGoalGuide = ""
        
        // 계획 가이드
        var newPlanGuide = ""
        
        // backButton 숨김여부
        var isShowBackButton: Bool {
            goalType != .firstGoal
        }
        
        // 텍스트필드 유효성 검사
        var textFieldValidate: Bool {
            goalType != .makePlan ? !goalInfo.planTitle.isEmpty : !goalInfo.goalTitle.isEmpty && !goalInfo.planTitle.isEmpty
        }
        
        // 시간설정 유효성 검사
        var timePickerValidate: Bool {
            goalInfo.startDate <= goalInfo.endDate
        }
        
        // 텍스트필드 유효성 검사
        var isButtonDisabled: Bool {
            !textFieldValidate || !timePickerValidate
        }
        
        // 시작날짜 구분
        var startDateTodayStr: String {
            calendar.isDate(goalInfo.startDate, inSameDayAs: .now) ? "오늘" : "내일"
        }
        
        // 종료날짜 구분
        var endDateTodayStr: String {
            calendar.isDate(goalInfo.endDate, inSameDayAs: .now) ? "오늘" : "내일"
        }
        
        // 시작날짜 문자 HH:mm
        var startDateStr: String {
            goalInfo.startDate.formatted("HH:mm")
        }
        
        // 종료날짜 문자 HH:mm
        var endDateStr: String {
            goalInfo.endDate.formatted("HH:mm")
        }
        
        // 오전/오후 + 시작날짜
        var startDateResultStr: String {
            startDateTodayStr + " " + startDateStr
        }
        
        // 오전/오후 + 종료날짜
        var endDateResultStr: String {
            endDateTodayStr + " " + endDateStr
        }
        
        // 종료날짜 결과 날짜가 다른경우 + 내일
        var endTimeResultStr: String {
            calendar.isDate(goalInfo.endDate, inSameDayAs: goalInfo.startDate) ? endDateStr : "내일" + " " + endDateStr
        }
        
        // 최종적으료 표시되는 날짜
        var resultTimeStr: String {
            startDateResultStr + " ~ " + endTimeResultStr
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
        case goToCompleteView(MakeGoal.State)
        
        // 뒤로가기
        case backButtonTapped
        
        // startPickerTapped
        case startPickerTapped
        
        // startPickerTapped
        case endPickerTapped
        
        case fetchTips
        case fetchTipsResponse(Guide)
    }
    
    @Dependency(\.guideClient) var guideClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .fetchTips:
                return .run { send in
                    let response = try await guideClient.fetchTips()
                    await send(.fetchTipsResponse(response))
                }
            case let .fetchTipsResponse(response):
                state.newGoalGuide = response.newGoalGuide
                state.newPlanGuide = response.newPlanGuide
                return .none
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
                    return .send(.goToCompleteView(state))
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
