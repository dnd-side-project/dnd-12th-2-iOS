//
//  CaledarFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//


import ComposableArchitecture
import Foundation

@Reducer
struct CalendarFeature {
    @ObservableState
    struct State {
        var yeanAndMonth = ""
        var days: [[Day]] = []
        var index = 0
        var startDate = Date()
        
        init() {
            self.index = 1
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case viewAppear
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.index):
                let lastIndex = state.days.count - 1
                let currentWeek = state.days[state.index].first?.date ?? Date()
                let lastWeek = state.days[state.index].last?.date ?? Date()
                
                // 첫번째거나 마지막 인덱스인경우 데이터 추가
                if state.index == 0 {
                    let previousStartWeek = currentWeek.addingWeeks(-1)
                    state.days.insert(makeWeek(startDate: previousStartWeek), at: 0)
                    state.index = 1 // insert시 인덱스 조정
                } else if state.index == lastIndex {
                    let nextStartWeek = currentWeek.addingWeeks(1)
                    state.days.append(makeWeek(startDate: nextStartWeek))
                }
                
                // 현재선택한 년도, 월 텍스트 변경
                state.yeanAndMonth = getYearMonthString(from: [currentWeek, lastWeek])
                return .none
            case .viewAppear:
                let currentStartWeek = state.startDate.startOfWeek() ?? Date()
                let previousStartWeek = currentStartWeek.addingWeeks(-1)
                let nextStartWeek = currentStartWeek.addingWeeks(1)
                state.days = [
                    makeWeek(startDate: previousStartWeek),
                    makeWeek(startDate: currentStartWeek),
                    makeWeek(startDate: nextStartWeek)
                ]
                return .none
            default:
                return .none
            }
        }
        ._printChanges()
    }
    
    func makeWeek(startDate: Date) -> [Day] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        
        return (0..<7).compactMap { offset in
            guard let date = Calendar.current.date(byAdding: .day, value: offset, to: startDate) else { return nil }
            return Day(
                date: date,
                day: formatter.string(from: date),
                dayNumber: String(Calendar.current.component(.day, from: date)),
                successCount: 0,
                totalCount: 0
            )
        }
    }
    
    func getYearMonthString(from dates: [Date]) -> String {
        guard let firstDate = dates.min(), let lastDate = dates.max() else { return "" }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"

        let firstString = formatter.string(from: firstDate)
        let lastString = formatter.string(from: lastDate)
      
        if firstString == lastString {
            return firstString
        } else {
            return "\(firstString) - \(lastString)"
        }
    }
}

