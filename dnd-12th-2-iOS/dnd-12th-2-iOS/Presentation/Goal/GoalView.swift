//
//  GoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalView: View {
    let store: StoreOf<MakeGoal>
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("목표생성")
                    .font(.title)
                Button(action: {
                    store.send(.completeButtonTapped)
                }, label: {
                    Text("goToComplete")
                })
            }
            .navigationBar(left: {
                DDBackButton(action: {})
                    .hidden(store.isShowBackButton)
            })
        }
    }
}

//#Preview {
//    GoalView()
//}
