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
                    ForEach(store.plans, id: \.self.planId) { item in
                        VStack(spacing: 16) {
                            let resultType: ResultType = [.fail, .ready, .success].randomElement()!
                            DDResultRow(result: resultType, title: item.title, action: {
                                store.send(.planCellTapped(planId: item.planId))
                            })
                            DDFeedbackRow(result: resultType == .fail ? .fail : .success, title: "다음에는 계획을 더 구체적으로 세워봐요!")
                        }
                    }
                    Spacer()
                        .frame(height: 16)
                }
                .padding(.horizontal, 16)
            }
            .overlay(alignment: .bottomTrailing, content: {
                DDFloatingButton {
                    store.send(.createButtonTapped)
                }
                .offset(x: -16, y: -25)
            })
        }
    }
}

//#Preview {
//    PlanListView()
//}
