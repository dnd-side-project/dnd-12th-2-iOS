//
//  Plan.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/4/25.
//

struct Plan: Hashable {
    let planId: Int
    let title: String
    let status: String
    let guide: String?
    let startDate: String
    let endDate: String
    let completedDate: String?
}
