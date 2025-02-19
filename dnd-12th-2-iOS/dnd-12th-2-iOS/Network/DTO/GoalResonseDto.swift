//
//  GoalResonseDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

struct GoalResonseDto: Decodable {
    let goalId: Int
    let title: String
    let successCount: Int
    let failureCount: Int
    let totalCount: Int
}
