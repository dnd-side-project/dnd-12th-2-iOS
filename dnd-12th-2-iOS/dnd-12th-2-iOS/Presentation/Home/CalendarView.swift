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
                                
                DDWeekView(days: [
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                    Day(day: "", dayNumber: "", successCount: 0, totalCount: 0)
                ])
                    .hidden()
                    .overlay (
                        TabView(selection: $store.index) {
                            ForEach(Array(store.days.enumerated()), id: \.offset) { offset, days in
                                DDWeekView(days: days)
                                    .tag(offset)
                                    
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    )
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .onAppear { store.send(.viewAppear) }
        }
    }
}

//#Preview {
//    CalendarView()
//}
