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
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Text("로그인뷰")
                Button(action: {
                    store.send(.loginButtonTapped)
                }, label: {
                    Text("Login")
                })
            }
        } destination: { store in
            switch store.case {
            case let .onboarding(store):
                OnboardingView(store: store)
            case let .goal(store):
                GoalView(store: store)
            }
        }

    }
}

//#Preview {
//    LoginView()
//}
