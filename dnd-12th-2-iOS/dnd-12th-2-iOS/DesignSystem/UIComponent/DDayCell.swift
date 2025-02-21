//
//  DDayCell.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/21/25.
//

import SwiftUI

struct DDayCell: View {
    let day: Day
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(day.day)
                    .font(.pretendard(size: 12, weight: .medium))
                    .foregroundStyle(Color.gray500)
                Spacer()
                    .frame(height: 2)
                
                Text(day.dayNumber)
                    .font(.pretendard(size: 16, weight: .semibold))
                    .foregroundStyle(Color.gray900)
                    .frame(height: 38)
                
                Spacer()
                    .frame(height: 2)
                
                LinearProgressView(shape: Capsule(), value: day.succesPercent)
                    .frame(height: 4)
            }
            .padding(4)
        }
        .background(isSelected ? Color.gray50: Color.clear)
        .cornerRadius(8)
        .overlay(alignment: .topTrailing){
            if day.totalCount != day.successCount {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(Color.red)
            } else {
                EmptyView()
            }
        }
    }
}

//#Preview {
//    DDayCell()
//}
