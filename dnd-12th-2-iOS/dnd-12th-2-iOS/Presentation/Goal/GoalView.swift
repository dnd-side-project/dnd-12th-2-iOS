//
//  GoalSettingView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/11/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalView: View {
    @Perception.Bindable var store: StoreOf<InitialGoalFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 4) {
                        Text("목표")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        DDRoundTextFiled(text: $store.goalTitle)
                        Text(store.newGoalGuide)
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
                        DDRoundTextFiled(text: $store.planTitle)
                        Text(store.newPlanGuide)
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
                        Text("\(store.startDate.formatted()) ~ \(store.endDate.formatted())")
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
                                store.send(.toggleStartTime)
                            }, label: {
                                Text(store.startDate.formatted(date: .omitted, time: .shortened))
                                    .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                    .foregroundStyle(Color.purple800)
                                Image(.iconUp)
                                    .rotationEffect(.degrees(store.isStartTimeToggle ? 0 : 180))
                            })
                        }
                        if store.isStartTimeToggle {
                            DatePicker("", selection: $store.startDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                        Spacer().frame(height: 8)
                        HStack {
                            Text("종료 시간")
                                .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                .foregroundStyle(Color.gray600)
                            Spacer()
                            Button(action: {
                                store.send(.toggleEndTime)
                            }, label: {
                                Text(store.endDate.formatted(date: .omitted, time: .shortened))
                                    .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                                    .foregroundStyle(Color.purple800)
                                Image(.iconUp)
                                    .rotationEffect(.degrees(store.isEndTimeToggle ? 0 : 180))
                            })
                        }
                        if store.isEndTimeToggle {
                            DatePicker("", selection: $store.endDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                    }
                }
                .padding(16)
                .offset(y: store.isStartTimeToggle ? -16.0 : 0.0)
                .animation(.easeInOut(duration: 0.3), value: store.isStartTimeToggle)
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
        .onAppear {
            store.send(.getTips)
        }
    }
}


//#Preview {
//    GoalSettingView()
//}
