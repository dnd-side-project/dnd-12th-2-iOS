//
//  PlanMapper.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/8/25.
//

extension PlanInfo {
    func toDto() -> PlanRequestDto {
        .init(title: title,
              startDate: startDate.toISO8601DateFormat(),
              endDate: endDate.toISO8601DateFormat())
    }
}
