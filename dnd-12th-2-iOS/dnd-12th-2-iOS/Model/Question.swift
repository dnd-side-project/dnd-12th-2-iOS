//
//  Question.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//

struct Answer: Hashable {
    let question: String
}

struct Question: Hashable {
    let section: Int
    let title: String
    let description: String
    let answers: [Answer]
}

