//
//  OnboardingView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {
    let store: StoreOf<Onboarding>
    var body: some View {
        VStack {
            Button(action: {
                store.send(.goToGoalView)
            }, label: {
                Text("goToGoalView")
            })
        }
        .navigationBarHidden(true)
    }
}

//#Preview {
//    OnboardingView()
//}
