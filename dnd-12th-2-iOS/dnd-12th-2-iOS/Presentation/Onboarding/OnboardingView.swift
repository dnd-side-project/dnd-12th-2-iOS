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
        WithPerceptionTracking {
            VStack {
                Text("현재 가장 관심 있는 \n목표 분야를 선택해 주세요.")
                    .foregroundStyle(Color.gray900)
                    .headingStyle2()
                    .alignmentLeading()
                
                Button(action: {
                    store.send(.goToGoalView)
                }, label: {
                    Text("goToGoalView")
                })
            }
            .navigationBar(left: {
                DDBackButton(action: {})
            }, right: {
                Text("")
            })
        }
    }
}

//#Preview {
//    OnboardingView()
//}
