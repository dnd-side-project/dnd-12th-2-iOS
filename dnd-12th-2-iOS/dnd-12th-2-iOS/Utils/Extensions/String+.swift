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
    
    func toDate(timeFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = timeFormat
            return formatter.date(from: self) ?? Date()
        }
    
    func toTimeFormat(inputFormat: String = "yyyy-MM-dd HH:mm:ss", outputFormat: String = "HH:mm") -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "ko_KR")
           dateFormatter.timeZone = TimeZone.current
           dateFormatter.dateFormat = inputFormat
           
           guard let date = dateFormatter.date(from: self) else { return "00:00" }
           
           dateFormatter.dateFormat = outputFormat
           return dateFormatter.string(from: date)
       }
}
