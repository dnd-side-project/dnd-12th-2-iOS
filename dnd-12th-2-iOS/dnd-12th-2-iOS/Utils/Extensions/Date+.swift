//
//  Date+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//
import Foundation
extension Date {
    func toShortDateFormat(timeFormat: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    func formatted(_ format: String = "yyyy년 M월 d일") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toDayString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        
        return formatter.string(from: self)
    }
    
    func toDayNumber() -> String {
        String(Calendar.current.component(.day, from: self))
    }
    
    func getWeekdayIndex() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
                
        return weekday - 1
    }
    
    func toISO8601DateFormat() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
        return dateFormatter.string(from: self)
    }
}
