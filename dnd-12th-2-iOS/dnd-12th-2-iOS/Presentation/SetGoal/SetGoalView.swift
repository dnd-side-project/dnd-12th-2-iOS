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
            Group {
                switch store.viewFlow {
                case .setGoal:
                    Text(store.viewFlow.title)
                    
                    DDTextField(text:  $store.goalTitle)
                    
                    TipView(store: store.scope(state: \.fetchTip, action: \.fetchTip))
                    
                    DDButton(action: {
                        store.send(.nextButtonTapped)
                    })
                case .setPlan:
                    Text(store.viewFlow.title)
                    
                    DDTextField(text: $store.planTitle)
                    
                    TipView(store: store.scope(state: \.fetchTip, action: \.fetchTip))
                    
                    DateGroup()
                    
                    DDButton(action: {
                        store.send(.nextButtonTapped)
                    })
                }
            }
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
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

extension SetGoalView {
    @ViewBuilder
    func DateGroup() -> some View {
        Text("시작날짜")
        DDatePicker(date: $store.startDate)
        Text("종료날짜")
        DDatePicker(date: $store.endDate)
    }
}

//#Preview {
//    SetGoalView()
//}
