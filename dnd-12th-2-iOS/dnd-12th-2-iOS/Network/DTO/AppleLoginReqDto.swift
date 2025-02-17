//
//  AppleLoginReqDto.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/17/25.
//

import Foundation

struct AppleLoginReqDto: Encodable {
    let code: String
    let deviceToken: String
}
