//
//  GoalSettingView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/11/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalSettingView: View {
    let store: StoreOf<GoalFeature>
    @State var text = ""
    @State var isStartTimeToggle = false
    @State var isEndTimeToggle = false
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 4) {
                        Text("목표")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        DDRoundTextFiled(text: $text)
                        Text("Tip 목표가 부담스럽다면 3개월 안에 실천할 수 있는 목표를 \n생각해보세요!".splitCharacter())
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.purple500)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    
                    VStack(spacing: 4) {
                        Text("계획")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        DDRoundTextFiled(text: $text)
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
                            .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                            .foregroundStyle(Color.gray500)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 8)
                        Divider().background(Color.gray50)
                        Spacer().frame(height: 8)
                        HStack {
                            Text("시작 시간")
                                .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                .foregroundStyle(Color.gray600)
                            Spacer()
                            Button(action: {
                                isEndTimeToggle = false
                                isStartTimeToggle.toggle()
                            }, label: {
                                Text("오늘 22:28")
                                    .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                    .foregroundStyle(Color.purple800)
                                Image(.iconUp)
                                    .rotationEffect(.degrees(isStartTimeToggle ? 0 : 180))
                            })
                        }
                        if isStartTimeToggle {
                            DDatePicker()
                        }
                        Spacer().frame(height: 8)
                        HStack {
                            Text("종료 시간")
                                .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                .foregroundStyle(Color.gray600)
                            Spacer()
                            Button(action: {
                                isStartTimeToggle = false
                                isEndTimeToggle.toggle()
                            }, label: {
                                Text("오늘 22:28")
                                    .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                    .foregroundStyle(Color.purple800)
                                Image(.iconUp)
                                    .rotationEffect(.degrees(isEndTimeToggle ? 0 : 180))
                            })
                        }
                        if isEndTimeToggle {
                            DDatePicker()
                        }
                    }
                }
                .padding(16)
                .offset(y: isStartTimeToggle ? -16.0 : 0.0)
                .animation(.easeInOut(duration: 0.3), value: isStartTimeToggle)
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
            }
            .scrollDisabled(true)
            
            DDButton(action: {
                store.send(.completeButtonTapped)
            })
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
        
        .navigationBar(left: {
            DDBackButton(action: {})
        })
    }
}

//#Preview {
//    GoalSettingView()
//}
