//
//  StatisticsResponseDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//

struct StatisticsResponseDto: Decodable {
    let date: String
    let successCount: Int
    let failureCount: Int
    let totalCount: Int
}
