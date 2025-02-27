//
//  OnboardingMapper.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

import Foundation

extension Array where Element == OnboardingResDto {
    func toEntity() -> [Question] {
        self.map { Question(questionId: $0.questionId, section: $0.order, title: $0.questionContent, description: $0.subContent, answers: $0.answers.map { Answer(text: $0.content, answerId: $0.answerId)})}
    }
}

extension Array where Element == Question {
    func toDto() -> OnboardingReqDto {
        OnboardingReqDto(data: self.map { OnboardingDto(question_id: $0.questionId, answer_id: $0.answers.first(where: {$0.isSelected})?.answerId ?? 1)})
    }
}
