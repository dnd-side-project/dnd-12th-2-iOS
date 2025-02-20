//
//  PlanMapper.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import Foundation

extension Array where Element == PlanResponseDto {
    func toEntity() -> [Plan] {
        self.map { Plan(planId: $0.planId, title: $0.title, status: $0.status, guide: $0.guide, startDate: $0.startDate, endDate: $0.endDate, completedDate: $0.completedDate)}
    }
}

