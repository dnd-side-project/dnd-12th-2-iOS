//
//  Goal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation

struct GoalInfo: Equatable {
    var goalTitle: String
    var planTitle: String
    var startDate: Date
    var endDate: Date
}

extension GoalInfo {
    static var makeGoal: GoalInfo {
        .init(goalTitle: "",
              planTitle: "",
              startDate: .now,
              endDate: .now)
    }
    
    func toDto() -> GoalReqDto {
        .init(goalTitle: goalTitle,
              planTitle: planTitle,
              startDate: startDate.toISO8601DateFormat(),
              endDate: endDate.toISO8601DateFormat())
    }
}
