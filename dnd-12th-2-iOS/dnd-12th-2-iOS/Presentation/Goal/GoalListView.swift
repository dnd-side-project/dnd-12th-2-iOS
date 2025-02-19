//
//  GoalListView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalListView: View {
    let store: StoreOf<GoalListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                Text("목표")
                    .font(.pretendard(size: 20, weight: .bold))
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 38)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(store.goalList, id: \.self.goalId) { item in
                            let successPercent = item.totalCount == 0 ? 0 : Double(item.successCount) / Double(item.totalCount)
                            DDProgessCard(title: item.title, value: successPercent, action: {})
                        }
                    }
                    .padding(16)
                }
            }
            .onAppear {
                store.send(.fetchGoals)
            }
        }
    }
}

//#Preview {
//    GoalListView()
//}
