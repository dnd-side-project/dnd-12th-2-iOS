//
//  String+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//
import Foundation

extension String {
    func splitCharacter() -> String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
    
    func toDate() -> Date {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: self) ?? Date()
        }
}
