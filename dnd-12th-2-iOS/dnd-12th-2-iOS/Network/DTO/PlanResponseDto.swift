//
//  PlanResponseDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

struct PlanResponseDto: Decodable {
    let planId: Int
    let title: String
    let status: String
    let guide: String
    let startDate: String
    let endDate: String
    let completedDate: String?
}
