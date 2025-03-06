//
//  GoalList.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/6/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalList: View {
    let store: StoreOf<FetchGoal>
    var body: some View {
        List(store.goalList, id: \.self) { item in
            VStack {
                Text("goalID: \(item.goalId)")
                Text(item.title)
            }
            .padding(20)
            .background(.gray)
            .onTapGesture {
                store.send(.cellTapped(goalId: item.goalId))
            }
        }
        .onAppear {
            store.send(.fetchGoals)
        }
    }
}

//#Preview {
//    GoalList()
//}
