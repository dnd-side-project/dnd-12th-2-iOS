//
//  OnboardingView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 16)
            
            Text("어떤 목표 분야에 \n가장 관심이 있으신가요?")
                .font(.pretendard(size: 22, weight: .bold))
                .foregroundStyle(Color.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 12)
            
            Text("당신의 스타일에 딱 맞는 실행 전략을 찾아드릴게요!")
                .font(.pretendard(size: 16, weight: .medium))
                .foregroundStyle(Color.gray600)
                .frame(maxWidth: .infinity, alignment: .leading)
                    
            Spacer()
                .frame(height: 86)
            VStack(spacing: 12) {
                DDRow(title: "건강/운동")
                DDRow(title: "건강/운동")
                DDRow(title: "건강/운동")
                DDRow(title: "건강/운동")
                DDRow(title: "건강/운동")
            }
            
            Spacer()
            
            DDButton(action: {})
        }
        .padding(.horizontal, 16)
        .navigationBar(left: {
            EmptyView()
        }, right: {
            StepCircle()
        })
    }
}

struct StepCircle: View {
    let currentStep = 1
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...3, id: \.self) { step in
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.purple100)
                    .overlay(Text("\(step)").font(.pretendard(size: 14, weight: .semibold)))
            }
        }
    }
}

#Preview {
    OnboardingView()
}
