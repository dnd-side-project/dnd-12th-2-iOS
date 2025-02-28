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
            Text("로그인뷰")
        } destination: { store in
            switch store.case {
            case .onboarding:
                OnboardingView()
            }
        }

    }
}

//#Preview {
//    LoginView()
//}
