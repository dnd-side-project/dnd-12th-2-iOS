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
            VStack(spacing: 0) {
                Text(store.questionnaire.questions[store.questionnaire.currentStep].title)
                    .foregroundStyle(Color.gray900)
                    .headingStyle2()
                    .alignmentLeading()
                    .padding(.top, 16)
                
                Text(store.questionnaire.questions[store.questionnaire.currentStep].description)
                    .foregroundStyle(Color.gray600)
                    .bodyLargeMedium()
                    .alignmentLeading()
                    .padding(.top, 12)
                
                LazyVStack(spacing: 12) {
                    ForEach(store.questionnaire.questions[store.questionnaire.currentStep].answers, id: \.self) { answer in
                        DDRow(title: answer.content)
                    }
                }
                .padding(.top, 50)
                
                Spacer()
                
                DDButton(action: {})
            }
            .navigationBar(left: {
                DDBackButton(action: {})
            }, right: {
                StepCircle(currentStep: 1)
            })
            .onAppear {
                store.send(.viewAppear)
            }
        }
    }
}

struct StepCircle: View {
    let currentStep: Int
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 6) {
                ForEach(1...3, id: \.self) { step in
                    let circleColor = currentStep >= step ? Color.purple700: Color.purple100
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
