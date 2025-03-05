//
//  GoalReqDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/4/25.
//

struct GoalReqDto: Encodable {
    let goalTitle: String
    let planTitle: String
    let startDate: String
    let endDate: String
}
