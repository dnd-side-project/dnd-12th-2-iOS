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

extension Array where Element == StatisticsResponseDto {
    func toDomain() -> [Day] {
        return self.map { Day(date: $0.date.toDate(timeFormat: "yyyy-MM-dd"),
                              day: $0.date.toDate(timeFormat: "yyyy-MM-dd").toDayString(),
                              dayNumber: $0.date.toDate(timeFormat: "yyyy-MM-dd").toDayNumber(),
                              successCount: $0.successCount,
                              failureCount: $0.failureCount,
                              totalCount: $0.totalCount)}    }
}
