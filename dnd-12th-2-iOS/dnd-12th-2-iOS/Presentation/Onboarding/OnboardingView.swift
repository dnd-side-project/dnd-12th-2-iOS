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
            QuestionForm(
                store: store.scope(state: \.questionnaire,
                                   action: \.questionnaire)
            )
        }
        .navigationBar(left: {
            DDBackButton(action: {
                store.send(.goToPrevPage)
            })
            .hidden(store.isFirstPage)
        }, right: {
            StepCircle(currentStep: store.questionnaire.currentStep + 1)
        })
        .onAppear {
            store.send(.fetchQuestion)
        }
    }
}


struct StepCircle: View {
    let currentStep: Int
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 6) {
                ForEach(1...3, id: \.self) { step in
                    let circleColor = currentStep >= step ? Color.purple500: Color.purple100
                    let fontColor = currentStep >= step ? Color.white : Color.purple700
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(circleColor)
                        .overlay(
                            Text("\(step)")
                                .bodyMediumSemibold()
                                .foregroundStyle(fontColor)
                        )
                }
            }
        }
    }
}

//#Preview {
//    OnboardingView()
//}
