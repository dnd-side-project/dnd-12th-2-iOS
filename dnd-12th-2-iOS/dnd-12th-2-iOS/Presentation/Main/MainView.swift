//
//  MainView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @Perception.Bindable var store: StoreOf<MainNavigation>
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    GoalList(store: store.scope(state: \.fetchGoal, action: \.fetchGoal))
                }
                .navigationBar(right: {
                    Button(action: {
                        store.send(.goToMyPage)
                    }, label: {
                        Text("마이페이지")
                    })
                })
            } destination: { store in
                switch store.case {
                case let .home(store):
                    HomeView(store: store)
                case let .setGoal(store):
                    SetGoalView(store: store)
                case let .myPage(store):
                    MyPageView(store: store)
                }
            }
        }
        
    }
}

//#Preview {
//    MainView()
//}
