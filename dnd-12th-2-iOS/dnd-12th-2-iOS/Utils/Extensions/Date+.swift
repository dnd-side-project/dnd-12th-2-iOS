//
//  Date+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//
import Foundation
extension Date {
    func toShortDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
