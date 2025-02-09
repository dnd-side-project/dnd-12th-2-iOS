//
//  OnboardingView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {
    let store: StoreOf<OnboardingFeature>
   
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 16)
                
                Text(store.questions[store.currentStep].title)
                    .font(.pretendard(size: 22, weight: .bold))
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 12)
                
                Text(store.questions[store.currentStep].description)
                    .font(.pretendard(size: 16, weight: .medium))
                    .foregroundStyle(Color.gray600)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 86)
                
                VStack(spacing: 12) {
                    ForEach(store.questions[store.currentStep].answers , id: \.self) {
                        DDRow(title: $0.question, isSelected: false)
                    }
                }
                
                Spacer()
                
                DDButton(action: { store.send(.goToPage(store.currentStep + 1)) })
            }
            .id(store.currentStep)
            .animation(.easeIn)
            .transition(store.currentStep >= store.prevStep ? .backslide : .forwardSlide)
            .padding(.horizontal, 16)
            .navigationBar(left: {
                DDBackButton(action: { store.send(.goToPage(store.currentStep - 1)) })
            }, right: {
                StepCircle(currentStep: store.currentStep + 1)
            })
        }
    }
}

struct StepCircle: View {
    let currentStep: Int
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 6) {
                ForEach(1...3, id: \.self) { step in
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(currentStep >= step ? Color.purple700: Color.purple100)
                        .overlay(
                            Text("\(step)")
                                .font(.pretendard(size: 14, weight: .semibold))
                                .foregroundStyle(currentStep >= step ? Color.white : Color.purple700)
                        )
                }
            }
        }
    }
}

#Preview {
    OnboardingView(store:  Store(initialState: OnboardingFeature.State()) {
        OnboardingFeature()
    })
}
