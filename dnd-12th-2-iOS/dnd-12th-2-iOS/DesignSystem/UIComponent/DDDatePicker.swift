//
//  DDDatePicker.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI
import UIKit

struct DDatePicker: View {
    @Binding var date: Date
    var onDateChange: (Date) -> Void

    @State private var selectedDay: Int = 0
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0

    var body: some View {
        HStack {
            DDPicker(items: ["오늘", "내일"])
                .frame(height: 56 * 3)
                .overlay(alignment: .top) {
                    Divider()
                        .offset(y: 56)
                    Divider()
                        .offset(y: 56 * 2)
                }
                .overlay(
                    Rectangle()
                        .foregroundStyle(Color.purple800)
                        .frame(height: 55)
                        .blendMode(.overlay)
                        .allowsHitTesting(false)
                )
            
            Spacer()
                .frame(width: 45)
            
            DDPicker(items: Array(0...23).map {String(format: "%02d", $0)})
                .frame(height: 56 * 3)
                .overlay(alignment: .top) {
                    Divider()
                        .offset(y: 56)
                    Divider()
                        .offset(y: 56 * 2)
                }
                .frame(width: 44)
                .overlay(
                    Rectangle()
                        .foregroundStyle(Color.purple800)
                        .frame(height: 55)
                        .blendMode(.overlay)
                        .allowsHitTesting(false))
            
            Spacer()
                .frame(width: 24)
            
            DDPicker(items: Array(0...59).map {String(format: "%02d", $0)})
                .frame(height: 56 * 3)
                .overlay(alignment: .top) {
                    Divider()
                        .offset(y: 56)
                    Divider()
                        .offset(y: 56 * 2)
                }
                .frame(width: 44)
                .overlay(
                    Rectangle()
                        .foregroundStyle(Color.purple800)
                        .frame(height: 55)
                        .blendMode(.overlay)
                        .allowsHitTesting(false)
                )
            Spacer()
                .frame(width: 45)
        }
        .frame(width: 307, height: 198)
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 15)
                .foregroundStyle(Color.white)
                .offset(y: 10)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .frame(height: 15)
                .foregroundStyle(Color.white)
                .offset(y: -10)
        }
        .onAppear {
            initializeFromDate()
        }
        .onChange(of: selectedDay) { _ in updateDate() }
        .onChange(of: selectedHour) { _ in updateDate() }
        .onChange(of: selectedMinute) { _ in updateDate() }
    }

    private func initializeFromDate() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        selectedDay = Calendar.current.isDateInToday(date) ? 0 : 1
        selectedHour = components.hour ?? 0
        selectedMinute = components.minute ?? 0
    }

    private func updateDate() {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        components.day! += selectedDay
        components.hour = selectedHour
        components.minute = selectedMinute
        if let newDate = Calendar.current.date(from: components) {
            date = newDate
            onDateChange(newDate)
        }
    }
}



//#Preview {
//    DDatePicker()
//}
