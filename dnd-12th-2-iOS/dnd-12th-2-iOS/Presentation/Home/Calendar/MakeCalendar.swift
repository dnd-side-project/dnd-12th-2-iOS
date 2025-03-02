//
//  Calendar.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/2/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MakeCalendar {
    @ObservableState
    struct State {
        var yearMonthString = ""
        var dayList: [[Day]] = []
        var index = 0
        var cellIndex = 0
    }
    
    enum Action: BindableAction {
        // 오늘일 기준 1년치 날짜데이터 생성
        case binding(BindingAction<State>)
        
        // 뷰가 나타나는 경우
        case viewAppear
        
        // 상단에뜨는 날짜 설정
        case setYearMonth(index: Int)
        
        // 해당 날짜를 기준으로 계획리스트를 불러온다
        case requestDate(Date)
    }
    
    let calendar = Calendar.current
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }()
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                // 캘린더 스크롤시 index 변경
            case .binding(\.index):
                let requestDate = state.dayList[state.index][3].date
                return .merge([
                    .send(.setYearMonth(index: state.index)),
                    .send(.requestDate(requestDate))
                ])
                // 상단에 나타나는 날짜 변경
            case let .setYearMonth(index):
                let dates = state.dayList[index].map { $0.date }
                guard let firstDate = dates.min(), let lastDate = dates.max() else { return .none }
                
                let firstString = formatter.string(from: firstDate)
                let lastString = formatter.string(from: lastDate)
                
                // 첫날짜 마지막날짜 같은지 비교
                if firstString == lastString {
                    state.yearMonthString = firstString
                } else {
                    state.yearMonthString = "\(firstString) - \(lastString)"
                }
                return .none
            case .viewAppear:
                let weekday = calendar.component(.weekday, from: .now)
                let startWeek = calendar.date(byAdding: .day, value: 1 - weekday, to: .now)!
                
                let afterDayList =
                (0...52).map {
                    let startWeekDate = calendar.date(byAdding: .weekOfYear, value: $0, to: startWeek) ?? Date()
                    return (0..<7).map {
                        let date = calendar.date(byAdding: .day, value: $0, to: startWeekDate)!
                        return Day(date: date,
                                   day: date.toDayString(),
                                   dayNumber: date.toDayNumber(),
                                   successCount: 0,
                                   failureCount: 0,
                                   totalCount: 0)
                    }
                }
                
                let beforeDayList =
                (-52...(-1)).map {
                    let startWeekDate = calendar.date(byAdding: .weekOfYear, value: $0, to: startWeek) ?? Date()
                    return (0..<7).map {
                        let date = calendar.date(byAdding: .day, value: $0, to: startWeekDate)!
                        return Day(date: date,
                                   day: date.toDayString(),
                                   dayNumber: date.toDayNumber(),
                                   successCount: 0,
                                   failureCount: 0,
                                   totalCount: 0)
                    }
                }
                let dayList = beforeDayList + afterDayList
                let midIndex = dayList.count / 2
                state.dayList = dayList
                state.index = midIndex
                state.cellIndex = dayList[midIndex].firstIndex(where: {calendar.isDate($0.date, inSameDayAs: .now)}) ?? 0
                
                return .send(.setYearMonth(index: midIndex))
            default:
                return .none
            }
        }
    }
}
