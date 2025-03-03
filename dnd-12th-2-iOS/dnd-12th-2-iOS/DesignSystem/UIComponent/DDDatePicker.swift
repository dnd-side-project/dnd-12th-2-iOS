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
    let calendar = Calendar.current
    @State private var selectedDay: String = "오늘"
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0

    var body: some View {
        HStack {
            DDPicker(selected: $selectedDay, items: ["오늘", "내일"])
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
            
            DDPicker(selected: $selectedHour, items: Array(0...23))
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
            
            DDPicker(selected: $selectedMinute, items: Array(0...59))
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
            selectedHour = calendar.component(.hour, from: date)
            selectedMinute = calendar.component(.minute, from: date)
        }.onChange(of: [selectedHour, selectedMinute]) { newValue in
            let hour = newValue[0]
            let minute = newValue[1]
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            component.hour = hour
            component.minute = minute
            if let newDate = calendar.date(from: component) {
                date = newDate
            }
        }.onChange(of: selectedDay) { newValue in            
            if newValue == "오늘" {
               date = calendar.date(byAdding: .day, value: -1, to: date) ?? Date()
            } else {
                date = calendar.date(byAdding: .day, value: 1, to: date) ?? Date()
            }
        }
    }
}



//#Preview {
//    DDatePicker()
//}
