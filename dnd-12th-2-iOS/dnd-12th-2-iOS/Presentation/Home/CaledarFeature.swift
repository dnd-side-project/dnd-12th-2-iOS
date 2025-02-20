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
        var goalId = 0
        init() {
            self.index = 1
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case viewAppear
        case fetchStatistics(goalId: Int)
        case fetchStatisticsResponse([[Day]])
        case addDays(Int, [Day])
    }
    
    @Dependency(\.goalClient) var goalClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .fetchStatisticsResponse(response):
                state.days = response
                return .none
            // 목표 변경시
            case let .fetchStatistics(goalId):
                state.goalId = goalId
                let currentWeek = state.days[state.index].first?.date ?? Date()
                let currentWeekStr = currentWeek.toShortDateFormat()
                let previousWeekStr = currentWeek.addingWeeks(-1).toShortDateFormat()
                let nextWeekStr = currentWeek.addingWeeks(1).toShortDateFormat()
                return .run { send in
                   let previousDays = try await goalClient.fetchStatistics(goalId, previousWeekStr)
                   let currentDays = try await goalClient.fetchStatistics(goalId, currentWeekStr)
                   let nextDays = try await goalClient.fetchStatistics(goalId, nextWeekStr)
                   await send(.fetchStatisticsResponse([previousDays, currentDays, nextDays]))
                }
            case .binding(\.index):
                let lastIndex = state.days.count - 1
                let currentWeek = state.days[state.index].first?.date ?? Date() // 현재 날짜의 인덱스
                let lastWeek = state.days[state.index].last?.date ?? Date()
                
                // 첫번째거나 마지막 인덱스인경우 데이터 추가
                if state.index == 0 {
                    let previousWeek = currentWeek.addingWeeks(-1)
                    let previousWeekStr = previousWeek.toShortDateFormat()
                    return .run { [state] send in
                        let previousDays = try await goalClient.fetchStatistics(state.goalId, previousWeekStr)
                        await send(.addDays(1, previousDays))
                    }
                } else if state.index == lastIndex {
                    let nextWeek = currentWeek.addingWeeks(1)
                    let nextWeekStr = nextWeek.toShortDateFormat()
                    return .run { [state] send in
                        let previousDays = try await goalClient.fetchStatistics(state.goalId, nextWeekStr)
                        await send(.addDays(0, previousDays))
                    }
                } else {
                    state.yeanAndMonth = getYearMonthString(from: [currentWeek, lastWeek])
                    return .none
                }
            case let .addDays(add, response):
                if add == 0 {
                    state.days.append(response)
                } else {
                    state.days.insert(response, at: 0)
                }
                state.index += add
                let currentWeek = state.days[state.index].first?.date ?? Date()
                let lastWeek = state.days[state.index].last?.date ?? Date()
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
                let currentWeek = state.days[state.index].first?.date ?? Date()
                let lastWeek = state.days[state.index].last?.date ?? Date()
                state.yeanAndMonth = getYearMonthString(from: [currentWeek, lastWeek])
                return .none
            default:
                return .none
            }
        }
//        ._printChanges()
    }
    
    func makeWeek(startDate: Date) -> [Day] {
        return (0..<7).compactMap { offset in
            guard let date = Calendar.current.date(byAdding: .day, value: offset, to: startDate) else { return nil }
            return Day(
                date: date,
                day: date.toDayString(),
                dayNumber: date.toDayNumber(),
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

