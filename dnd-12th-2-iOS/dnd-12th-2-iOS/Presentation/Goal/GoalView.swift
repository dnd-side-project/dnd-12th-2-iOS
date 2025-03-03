//
//  GoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalView: View {
    @Perception.Bindable var store: StoreOf<MakeGoal>
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                VStack( spacing: 0) {
                    Text("목표")
                        .bodyXLargeSemibold()
                        .alignmentLeading()
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 16)
                    DDRoundTextFiled(text: $store.goalInfo.goalTitle)
                        .padding(.top, 8)
                    
                    Text(store.newGoalGuide)
                        .bodyMediumMedium()
                        .alignmentLeading()
                        .foregroundStyle(Color.purple500)
                        .padding(.top, 4)
                    
                    Text("계획")
                        .bodyXLargeSemibold()
                        .alignmentLeading()
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 32)
                    DDRoundTextFiled(text: $store.goalInfo.planTitle)
                        .padding(.top, 8)
                    
                    Text(store.newPlanGuide)
                        .bodyMediumMedium()
                        .alignmentLeading()
                        .foregroundStyle(Color.purple500)
                        .padding(.top, 4)
                    
                    Text("시간")
                        .bodyXLargeSemibold()
                        .alignmentLeading()
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 32)
                    Divider()
                        .padding(.vertical, 8)
                    HStack {
                        Text("시작 시간")
                            .bodyMediumMedium()
                            .foregroundStyle(Color.gray600)
                        Spacer()
                        HStack {
                            Text(store.startDateResultStr)
                                .bodyMediumMedium()
                                .foregroundStyle(Color.purple800)
                            Image(.iconUp)
                                .rotationEffect(.degrees(store.isShowStartPicker ? 0 : 180))
                        }
                        .onTapGesture {
                            store.send(.startPickerTapped)
                        }
                    }
                    if store.isShowStartPicker {
                        DDatePicker(date: $store.goalInfo.startDate)
                    }
                    
                    HStack {
                        Text("종료 시각")
                            .bodyMediumMedium()
                            .foregroundStyle(Color.gray600)
                        Spacer()
                        HStack {
                            Text(store.endDateResultStr)
                                .bodyMediumMedium()
                                .foregroundStyle(Color.purple800)
                            Image(.iconUp)
                                .rotationEffect(.degrees(store.isShowEndPicker ? 0 : 180))
                        }
                        .onTapGesture {
                            store.send(.endPickerTapped)
                        }
                    }
                    
                    if store.isShowEndPicker {
                        DDatePicker(date: $store.goalInfo.endDate)
                    }
                    Spacer()
                    
                    
                }
                .ignoresSafeArea(.keyboard)
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
                DDButton(isDisable: store.isButtonDisabled, action: {
                    store.send(.completeButtonTapped)
                })
            }
            .navigationBar(left: {
                DDBackButton(action: {})
                    .hidden(!store.isShowBackButton)
            })
            .onAppear {
                store.send(.fetchTips)
            }
        }
    }
}

#Preview {
    GoalView(store: Store(initialState: MakeGoal.State(), reducer: {
        MakeGoal()
    }))
}
