//
//  GoalSettingView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/11/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalSettingView: View {
    @State var text = ""
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 0) {
                        Text("목표")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 4)
                        DDRoundTextFiled(text: $text)
                            
                        Spacer().frame(height: 4)
                        Text("Tip 목표가 부담스럽다면 3개월 안에 실천할 수 있는 목표를 생각해보세요!")
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.purple500)
                            .frame(maxWidth: .infinity, alignment: .leading)                            
                    }
                    
                    VStack(spacing: 0) {
                        Text("계획")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 4)
                        DDRoundTextFiled(text: $text)
                        
                        Spacer().frame(height: 4)
                        Text("TIp! 할 일이 많다면, 가장 쉬운 것부터 시작해보세요!")
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.purple500)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack(spacing: 0) {
                        Text("시간")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 12)
                        
                        Text("오늘 22:28 ~ 23:42")
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.gray500)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                                    
                        DDatePicker()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 28)
            }
            DDButton(action: {})
        }
        .navigationBar(left: {
            DDBackButton(action: {})
        })
    }
}

#Preview {
    GoalSettingView()
}
