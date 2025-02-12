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
                
                // 타이틀
                Text(store.questions[store.currentStep].title)
                    .font(.pretendard(size: 22, weight: .bold), lineHeight: 31)
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 12)
                
                Text(store.questions[store.currentStep].description)
                    .font(.pretendard(size: 16, weight: .medium), lineHeight: 24)
                    .foregroundStyle(Color.gray600)
                    .frame(alignment: .leading)
                    .fixedSize()
                    .multilineTextAlignment(.leading)
                
                Spacer().frame(height: 86)
                
                if !store.isLastPage {
                    VStack(spacing: 12) {
                        ForEach(Array(store.questions[store.currentStep].answers.enumerated()) , id: \.self.offset) { (index, answer) in
                            DDRow(title: answer.text, isSelected: answer.isSelected)
                                .onTapGesture {
                                    store.send(.answerTapped(index))
                                }
                        }
                    }
                } else {
                    Image(.questionResult1)
                    Spacer()
                        .frame(height: 8)
                    Image(.questionResult2)
                }
                
                Spacer()
                
                if store.isLastPage {
                    Text("언제든지 [프로필 > 설정 > 알림]에서 변경할 수 있어요.")
                        .font(.pretendard(size: 14, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.gray500)
                    
                    Spacer()
                        .frame(height: 12)
                }
                DDButton(title: store.isLastPage ? "알림받고 목표에 도달하기" : "다음", action: { store.send(.goToPage(store.currentStep + 1)) })
            }
            .padding(.horizontal, 16)
            .id(store.currentStep)
            .animation(.default, value: store.currentStep)
            .transition(store.isNextPage ? .backslide : .forwardSlide)     
            .navigationBar(left: {
                DDBackButton(action: { store.send(.goToPage(store.currentStep - 1)) })
                    .hidden(store.isFirstPage)
            }, right: {
                StepCircle(currentStep: store.currentStep + 1)
                    .hidden(store.isLastPage)
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
