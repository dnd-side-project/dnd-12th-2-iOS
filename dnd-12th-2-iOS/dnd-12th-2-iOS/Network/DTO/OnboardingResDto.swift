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

extension Array where Element == OnboardingResDto {
    func toDomain() -> [Question] {
        map { Question(questionId: $0.questionId,
                       section: $0.order,
                       title: $0.questionContent,
                       description: $0.subContent,
                       answers: $0.answers.toDomain())}
    }
}

extension Array where Element == AnswerDto {
    func toDomain() -> [Answer] {
        map { Answer(answerId: $0.answerId,
                     content: $0.content)}
    }
}
