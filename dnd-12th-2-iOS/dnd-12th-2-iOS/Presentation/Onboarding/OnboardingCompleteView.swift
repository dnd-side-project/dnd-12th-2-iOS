//
//  OnboardingCompleteView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/1/25.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingCompleteView: View {
    let store: StoreOf<Onboarding>
    @State private var offsetAnim = false
    @State private var tranparentAnim = false
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                Text("목표 달성, \n알림 하나로 더 가까워집니다!")
                    .foregroundStyle(Color.gray900)
                    .headingStyle2()
                    .alignmentLeading()
                    .padding(.top, 16)
                
                Text("즉각적인 행동이 목표 달성률을 30% 높인다는 연구 결과가 있습니다. 알림으로 중요한 순간을 놓치지 마세요!")
                    .foregroundStyle(Color.gray600)
                    .bodyLargeMedium()
                    .alignmentLeading()
                    .padding(.top, 12)
                
                Image("questionResult1")
                    .opacity(tranparentAnim ? 1 : 0)
                    .offset(y: offsetAnim ? 0 : 20)
                    .animation(.easeOut(duration: 0.8), value: offsetAnim)
                    .animation(.easeOut(duration: 1.2), value: tranparentAnim)
                    .padding(.top, 60)
                
                Image("questionResult2")
                    .opacity(tranparentAnim ? 1 : 0)
                    .offset(y: offsetAnim ? 0 : 30)
                    .animation(.easeOut(duration: 1.0), value: offsetAnim)
                    .animation(.easeOut(duration: 1.5), value: tranparentAnim)
                
                    .padding(.top, 8)
                
                Spacer()
                
                Text("언제든지 [프로필 > 설정 > 알림]에서 변경할 수 있어요.")
                    .bodyMediumMedium()
                    .foregroundStyle(Color.gray500)
                    .padding(.bottom, 12)
                
                DDButton(title: "알림받고 목표에 도달하기", action: {
                    store.send(.goToGoalView)
                })
            }
            .onAppear {
                offsetAnim = true
                tranparentAnim = true
            }
            .onDisappear {
                offsetAnim = false
                tranparentAnim = false
            }
            .navigationBar(left: {
                DDBackButton(action: {
                    store.send(.backButtonTapped)
                })
            })
        }
    }
}

//#Preview {
//    OnboardingCompleteView()
//}
