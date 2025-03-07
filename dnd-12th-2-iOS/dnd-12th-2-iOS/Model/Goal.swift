//
//  Goal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/6/25.
//

struct Goal: Hashable {
    let goalId: Int
    let title: String
    let successCount: Int
    let failureCount: Int
    let totalCount: Int
}
