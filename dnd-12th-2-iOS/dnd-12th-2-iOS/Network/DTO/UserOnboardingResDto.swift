//
//  UserOnboardingResDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/8/25.
//

struct UserOnboardingResDto: Decodable {
    let checkOnboardingDone: Bool
    let data: [UserAnswerResDto]
}

struct UserAnswerResDto: Decodable {
    let questionContent: String
    let answerContent: String
}
