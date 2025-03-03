//
//  Goal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

import Foundation

struct Goal: Equatable {
    var goalTitle: String
    var planTitle: String
    var startDate: Date
    var endDate: Date
}

extension Goal {
    static var makeGoal: Goal {
        .init(goalTitle: "",
              planTitle: "",
              startDate: .now,
              endDate: .now)
    }
}
