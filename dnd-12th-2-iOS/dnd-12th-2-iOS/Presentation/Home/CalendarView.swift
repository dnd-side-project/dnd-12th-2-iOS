//
//  CalendarView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//

import SwiftUI
import ComposableArchitecture

struct CalendarView: View {
    @Perception.Bindable var store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithPerceptionTracking {
            
            VStack(spacing: 8){
                Text(store.yeanAndMonth)
                    .font(.pretendard(size: 16, weight: .medium))
                    .foregroundStyle(Color.gray600)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 8) {
                    HStack(spacing: 13) {
                        ForEach([
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                            Day(day: "", dayNumber: "", successCount: 0, totalCount: 0)
                        ], id: \.self) { day in
                            DDayCell(day: day, isSelected: true)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .hidden()
                .overlay (
                    TabView(selection: $store.index) {
                        ForEach(Array(store.days.enumerated()), id: \.offset) { offset, days in
                            VStack(spacing: 8) {
                                HStack(spacing: 13) {
                                    ForEach(Array(days.enumerated()), id: \.element.date) { index, day in
                                        DDayCell(day: day, isSelected: store.cellIndex == index)
                                            .onTapGesture { _ in
                                                store.send(.dayCellTapped(goalId: store.goalId, date: day.date.toShortDateFormat()))
                                                store.send(.setIndex(index))
                                            }
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                            .tag(offset)
                        }
                    }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                )
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .onAppear {
                if !store.hasAppeard {
                    store.send(.viewAppear)
                }
            }
        }
    }
}

//#Preview {
//    CalendarView()
//}
