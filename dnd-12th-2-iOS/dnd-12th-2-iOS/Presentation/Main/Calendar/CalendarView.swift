//
//  CalendarView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//

import SwiftUI
import ComposableArchitecture

struct CalendarView: View {
    @Perception.Bindable var store: StoreOf<MakeCalendar>
    
    var body: some View {
        WithPerceptionTracking {
            
            VStack(spacing: 8){
                Text(store.yearMonthString)
                    .bodyLargeMedium()
                    .alignmentLeading()
                    .foregroundStyle(Color.gray600)
                
                VStack(spacing: 8) {
                    HStack(spacing: 13) {
                        ForEach((0..<7).map { _ in Day(day: "", dayNumber: "", successCount: 0, failureCount: 0, totalCount: 0)}, id: \.self) { day in
                            DDayCell(day: day, isSelected: false)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .hidden()
                .overlay (
                    TabView(selection: $store.index) {
                        ForEach(Array(store.dayList.enumerated()), id: \.offset) { (offset, dayList) in
                            LazyVStack(spacing: 8) {
                                HStack(spacing: 13) {
                                    ForEach(Array(dayList.enumerated()), id: \.offset) { (offset, day) in
                                        DDayCell(day: day, isSelected: offset == store.cellIndex)
                                            .onTapGesture {
                                                store.send(.cellTapped(index: offset))
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
            .padding(.top, 16)
            .onAppear {
                store.send(.viewAppear)
            }
        }
    }
}

//#Preview {
//    CalendarView()
//}
