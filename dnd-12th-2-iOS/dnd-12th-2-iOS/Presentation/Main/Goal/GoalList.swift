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
                Text("title: \(item.title)")
            }
            .padding()
            .onTapGesture {
                store.send(.cellTapped(item))
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
