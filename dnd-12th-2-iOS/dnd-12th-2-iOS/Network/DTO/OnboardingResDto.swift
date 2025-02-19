//
//  OnboardingResDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

struct OnboardingResDto: Decodable {
    let questionId: Int
    let questionContent: String
    let subContent: String
    let order: Int
    let answers: [AnswerDto]
}

struct AnswerDto: Decodable {
    let answerId: Int
    let content: String
}
