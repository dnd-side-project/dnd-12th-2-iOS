//
//  Tip.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/20/25.
//

import Foundation

struct Tip: Codable, Hashable {
    let code, message: String
    let data: Guide
}

struct Guide: Codable, Hashable {
    let newGoalGuide: String
    let newPlanGuide: String
}
