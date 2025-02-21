//
//  GoalMapper.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

extension Array where Element == GoalResonseDto {
    func toEntity() -> [Goal] {
        self.map { Goal(goalId: $0.goalId, title: $0.title, successCount: $0.successCount, failureCount: $0.failureCount, totalCount: $0.totalCount) }
    }
}

extension Array where Element == StatisticsResponseDto {
    func toEntity() -> [Day] {        
        return self.map { Day(date: $0.date.toDate(timeFormat: "yyyy-MM-dd"),
                       day: $0.date.toDate(timeFormat: "yyyy-MM-dd").toDayString(),
                       dayNumber: $0.date.toDate(timeFormat: "yyyy-MM-dd").toDayNumber(),
                       successCount: $0.successCount,
                       failureCount: $0.failureCount,
                       totalCount: $0.totalCount)}
    }
}
