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
