//
//  Question.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//
import Foundation

struct Answer: Hashable {
    let text: String
    var isSelected: Bool = false
    let answerId: Int
}

struct Question: Hashable {
    let questionId: Int
    let section: Int
    let title: String
    let description: String
    var answers: [Answer]
}

