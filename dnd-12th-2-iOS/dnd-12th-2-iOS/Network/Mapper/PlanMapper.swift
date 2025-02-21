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

extension Array where Element == PlanGroupResponseDto {
    func toEntity() -> [PlanGroup] {
        // 날짜별 Plan을 저장할 딕셔너리 (key: 날짜 문자열, value: [Plan])
        var dateGroupedPlans: [String: [Plan]] = [:]
        
        // 서버에서 받은 각 PlanGroupResponseDto 내부의 PlanResponseDto들을 순회
        for planGroupDto in self {
            for planDto in planGroupDto.plans {
                // PlanResponseDto를 Plan으로 변환
                let plan = Plan(
                    planId: planDto.planId,
                    title: planDto.title,
                    status: planDto.status,
                    guide: planDto.guide,
                    startDate: planDto.startDate,
                    endDate: planDto.endDate,
                    completedDate: planDto.completedDate
                )
                
                
                let start = plan.startDate.toDate()
                      let end = plan.endDate.toDate()
                
                var currentDate = start
                // startDate부터 endDate까지의 날짜를 모두 그룹에 추가
                while currentDate <= end {
                    let dateKey = currentDate.toShortDateFormat(timeFormat: "yyyy-MM-dd HH:mm:ss")
                    dateGroupedPlans[dateKey, default: []].append(plan)
                    // 다음 날로 이동
                    guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { break }
                    currentDate = nextDay
                }
            }
        }
        
        // 딕셔너리의 각 날짜별 Plan 배열을 PlanGroup으로 변환
        let planGroups: [PlanGroup] = dateGroupedPlans.map { date, plans in
            return PlanGroup(dateGroup: date, plans: plans)
        }
        
        // 날짜 순서대로 정렬 ("yyyy-MM-dd" 포맷이므로 문자열 정렬이 올바른 순서)
        return planGroups.sorted { $0.dateGroup < $1.dateGroup }
    }    
}
