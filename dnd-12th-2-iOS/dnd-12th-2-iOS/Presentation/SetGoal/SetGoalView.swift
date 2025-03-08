//
//  SetGoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import SwiftUI
import ComposableArchitecture

struct SetGoalView: View {
    @Perception.Bindable var store: StoreOf<SetGoalFlow>
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text(store.viewFlow.title)
                
                DDTextField(text: store.viewFlow == .setGoal ? $store.goalTitle : $store.planTitle)
                
                TipView(store: store.scope(state: \.fetchTip, action: \.fetchTip))
                
                DDButton(action: {
                    store.send(.nextButtonTapped)
                })
            }
            .navigationBar(left: {
                DDBackButton(action: {
                    store.send(.backButtonTapped)
                })
            })
            .id(store.viewFlow)
            .animation(.default, value: store.viewFlow)
            .transition(store.isFoward ? AnyTransition.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)) :   AnyTransition.asymmetric(
                    insertion: .move(edge: .leading),
                    removal: .move(edge: .trailing)))
        }
    }
}

//#Preview {
//    SetGoalView()
//}
