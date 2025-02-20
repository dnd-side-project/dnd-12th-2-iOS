//
//  Day.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//

import Foundation

struct Day: Hashable {
    var date: Date = Date()
    let day: String
    let dayNumber: String
    let successCount: Int
    let totalCount: Int
    
    var succesPercent: Double {
        self.totalCount == 0 ? 0 : Double(self.successCount) / Double(self.totalCount)
    }
}
