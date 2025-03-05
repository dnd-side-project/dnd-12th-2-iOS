//
//  GuideResponseDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/3/25.
//

struct GuideResponseDto: Decodable {
    let newGoalGuide: String
    let newPlanGuide: String
}

extension GuideResponseDto {
    func toDomain() -> Guide {
        .init(newGoalGuide: newGoalGuide, newPlanGuide: newPlanGuide)
    }
}
