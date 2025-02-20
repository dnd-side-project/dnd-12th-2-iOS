//
//  DDWeekView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDWeekView: View {
    let days: [Day]
    @State var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 8) {            
            HStack(spacing: 13) {
                ForEach(days, id: \.self) { day in
                    DDWeekCell(weekDay: day.day, weekNumber: Int(day.dayNumber) ?? 0, isSelected: false)                        
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct DDWeekCell: View {
    let weekDay: String
    let weekNumber: Int
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(weekDay)
                    .font(.pretendard(size: 12, weight: .medium))
                    .foregroundStyle(Color.gray500)
                Spacer()
                    .frame(height: 2)
                
                Text("\(weekNumber)")
                    .font(.pretendard(size: 16, weight: .semibold))
                    .foregroundStyle(Color.gray900)
                    .frame(height: 38)
                
                Spacer()
                    .frame(height: 2)
                
                LinearProgressView(shape: Capsule(), value: 0.3)
                    .frame(height: 4)
            }
            .padding(4)
        }
        .background(isSelected ? Color.gray50: Color.clear)
        .cornerRadius(8)
        .overlay(alignment: .topTrailing){
            Circle()
                .frame(width: 8, height: 8)
                .foregroundStyle(Color.red)
        }
    }
}

//#Preview {
//    DDWeekView()
//}
