//
//  CalendarView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//

import SwiftUI
import ComposableArchitecture

struct CalendarView: View {
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        VStack(spacing: 8){
            Text("2025년 1월")
                .font(.pretendard(size: 16, weight: .medium))
                .foregroundStyle(Color.gray600)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            DDWeekView()
                .hidden()
                .overlay (
                    TabView {
                        DDWeekView()
                        DDWeekView()
                        DDWeekView()
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                )
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    CalendarView()
//}
