//
//  FirstGoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import SwiftUI
import ComposableArchitecture

struct FirstGoalView: View {
    @Perception.Bindable var store: StoreOf<FirstGoalFlow>
    var body: some View {
        WithPerceptionTracking {
            Group {
                switch store.viewFlow {
                case .setGoal:
                    VStack {
                        Text(store.viewFlow.title)
                        TextField(text: $store.goalTitle, label: {Text("ex)OO에서 OO하기")})
                        Text(store.newGoalGuide)
                        Spacer()
                        DDButton(action: { store.send(.goToNextStep) })
                    }
                    .navigationBar(left: {
                        EmptyView()
                    })
                case .setPlan:
                    VStack {
                        Text(store.viewFlow.title)
                        TextField(text: $store.planTitle, label: {Text("ex)OO에서 OO하기")})
                        Text(store.newPlanGuide)
                        Spacer()
                        DDButton(action: { store.send(.goToNextStep) })
                    }
                    .navigationBar(left: {
                        DDBackButton(action: { store.send(.goToPrevStep) })
                    })
                case .result:
                    VStack {
                        Text(store.goalTitle)
                        Text(store.planTitle)
                        Text("시작날짜")
                        DDatePicker(date: $store.startDate)
                        Text("종료날짜")
                        DDatePicker(date: $store.endDate)
                        Spacer()
                        DDButton(action: { store.send(.completeButtonTapped) })
                    }
                    .navigationBar(left: {
                        DDBackButton(action: { store.send(.goToPrevStep) })
                    })
                }
            }
            .animation(.default, value: store.viewFlow)
            .transition(store.isForward ? AnyTransition.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)) :   AnyTransition.asymmetric(
                    insertion: .move(edge: .leading),
                    removal: .move(edge: .trailing)))
            .onAppear {
                store.send(.fetchTips)
            }
        }
    }
}

//#Preview {
//    FirstGoalView()
//}
