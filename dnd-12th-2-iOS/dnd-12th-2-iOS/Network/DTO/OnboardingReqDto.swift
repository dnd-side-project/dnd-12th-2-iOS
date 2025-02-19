//
//  OnboardingReqDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

struct OnboardingReqDto: Encodable {
    let data: [OnboardingDto]
}

struct OnboardingDto: Encodable {
    let question_id: Int
    let answer_id: Int
}
