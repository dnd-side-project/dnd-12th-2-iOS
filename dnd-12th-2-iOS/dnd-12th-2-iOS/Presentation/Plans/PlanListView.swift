//
//  PlanListView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import SwiftUI
import ComposableArchitecture

struct PlanListView: View {
    let store: StoreOf<PlanListFeature>
    let isScroll: Bool
    
    var body: some View {
        WithPerceptionTracking {
            if isScroll {
                ScrollView(showsIndicators: false) {
                    content
                }
            } else {
                content
            }
            
        }
    }
    
    var content: some View {
        LazyVStack(spacing: 16) {
            ForEach(store.plans, id: \.self.dateGroup) { groupItem in
                Text(groupItem.dateGroup)
                    .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(Array(groupItem.plans.sorted(by: { $0.startDate.toDate() < $1.startDate.toDate() }).enumerated()), id: \.element.planId) { offset, item in
                    VStack(spacing: 16) {
                        DDResultRow(plan: item, action: {
                            store.send(.planCellTapped(planId: item.planId))
                        })
                        if offset < groupItem.plans.count - 1 {
                            DDFeedbackRow(result: item.feedbackType, title: item.guide)
                        }
                    }
                    .id("\(item.planId)-\(groupItem.dateGroup)")
                }
            }
            
            if store.historyCount > 0 {
                Spacer()
                    .frame(height: 16)
            }
        }
        .padding(.horizontal, 16)
        //        .animation(.default, value: store.plans.count)
    }
}

//#Preview {
//    PlanListView()
//}
