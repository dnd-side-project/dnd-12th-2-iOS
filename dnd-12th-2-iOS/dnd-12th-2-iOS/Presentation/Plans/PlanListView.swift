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
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(store.plans, id: \.self) { groupItem in
                        Text(groupItem.startDate.toShortDateFormat())
                            .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(Array(groupItem.plans.enumerated()), id: \.element.planId) { offset, item in
                            VStack(spacing: 16) {
                                DDResultRow(result: item.resultType, title: item.title, action: {
                                    store.send(.planCellTapped(planId: item.planId))
                                })
                                if offset != groupItem.plans.count - 1  {
                                    DDFeedbackRow(result: item.feedbackType, title: item.guide)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 16)
                }
                .padding(.horizontal, 16)
            }
          
        }
    }
}

//#Preview {
//    PlanListView()
//}
