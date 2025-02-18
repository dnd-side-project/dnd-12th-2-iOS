//
//  AppleLoginResDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/17/25.
//

import Foundation

struct AppleLoginResDto: Decodable {
    let nickname: String
    let email: String
    let profileImageUrl: String?
    let jwtTokenDto: JwtTokenDto
}

struct JwtTokenDto: Decodable {
    let accessToken: String
    let refreshToken: String
}
