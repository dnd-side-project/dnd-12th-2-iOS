//
//  CalendarView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//

import SwiftUI
import ComposableArchitecture

struct CalendarView: View {
    let store: StoreOf<Calendar>
    
    var body: some View {
        WithPerceptionTracking {
            
            VStack(spacing: 8){
                Text("2025년 1월")
                    .bodyLargeMedium()
                    .alignmentLeading()
                    .foregroundStyle(Color.gray600)
                
                VStack(spacing: 8) {
                    HStack(spacing: 13) {
                        ForEach([
                            Day(day: "월", dayNumber: "1", successCount: 0, failureCount: 0, totalCount: 0),
                            Day(day: "화", dayNumber: "2", successCount: 0, failureCount: 0, totalCount: 0),
                            Day(day: "수", dayNumber: "3", successCount: 0, failureCount: 0, totalCount: 0),
                            Day(day: "목", dayNumber: "4", successCount: 0, failureCount: 0, totalCount: 0),
                            Day(day: "금", dayNumber: "5", successCount: 0, failureCount: 0, totalCount: 0),
                            Day(day: "토", dayNumber: "6", successCount: 0, failureCount: 0, totalCount: 0),
                            Day(day: "일", dayNumber: "7", successCount: 0, failureCount: 0, totalCount: 0)
                        ], id: \.self) { day in
                            DDayCell(day: day, isSelected: false)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .hidden()
                .overlay (
                    TabView(selection: .constant(52)) {
                        ForEach(1...104, id: \.self) { index in
                            LazyVStack(spacing: 8) {
                                HStack(spacing: 13) {
                                    ForEach(1...7, id: \.self) { index in
                                        DDayCell(day:  Day(day: "일", dayNumber: "7", successCount: 0, failureCount: 0, totalCount: 0), isSelected: false)
                                    }
                                }
                                .padding(.vertical, 8)
                            }.tag(index)
                        }
                    }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                )
                .frame(maxWidth: .infinity)
            }
        }
    }
}

//#Preview {
//    CalendarView()
//}
