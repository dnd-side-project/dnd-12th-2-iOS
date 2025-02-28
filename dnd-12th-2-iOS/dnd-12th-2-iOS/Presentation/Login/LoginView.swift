//
//  LoginView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @Perception.Bindable var store: StoreOf<LoginNavigation>
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Text("로그인뷰")
                        .font(.title)
                    Button(action: {
                        store.send(.loginButtonTapped)
                    }, label: {
                        Text("Login")
                    })
                }
            } destination: { store in
                switch store.case {
                case let .complete(store):
                    OnboardingCompleteView(store: store)
                case let .onboarding(store):
                    OnboardingView(store: store)
                case let .goal(store):
                    GoalView(store: store)
                case let .goalComplete(store):
                    GoalCompleteView(store: store)            
                }
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
