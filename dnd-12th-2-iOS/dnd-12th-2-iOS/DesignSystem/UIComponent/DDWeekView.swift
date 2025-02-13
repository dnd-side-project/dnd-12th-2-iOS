//
//  DDWeekView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDWeekView: View {
    @State var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 8) {
            Text("2025년 1월")
                .font(.pretendard(size: 16, weight: .medium))
                .foregroundStyle(Color.gray600)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 13) {
                ForEach(1...7, id: \.self) { number in
                    DDWeekCell(weekDay: "월", weekNumber: number, isSelected: number == selectedIndex)
                        .onTapGesture { _ in
                            selectedIndex = number
                        }
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

#Preview {
    DDWeekView()
}
