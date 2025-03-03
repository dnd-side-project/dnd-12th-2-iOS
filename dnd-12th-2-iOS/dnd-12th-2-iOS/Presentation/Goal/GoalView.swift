//
//  GoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalView: View {
    let store: StoreOf<MakeGoal>
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                
                VStack( spacing: 0) {
                    
                    Text("목표")
                        .bodyXLargeSemibold()
                        .alignmentLeading()
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 16)
                    DDRoundTextFiled(text: .constant(""))
                        .padding(.top, 8)
                    
                    Text("진행 상황을 측정할 수 있도록 목표를 세워보세요.  예: ‘한 달 동안 영어책 1권 완독’")
                        .bodyMediumMedium()
                        .alignmentLeading()
                        .foregroundStyle(Color.purple500)
                        .padding(.top, 4)
                    
                    
                    
                    Text("계획")
                        .bodyXLargeSemibold()
                        .alignmentLeading()
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 32)
                    DDRoundTextFiled(text: .constant(""))
                        .padding(.top, 8)
                    
                    Text("빠르게 끝낼 것과 중요한 것을 구분해볼까요?")
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
                        Text("시작시간")
                            .bodyMediumMedium()
                            .foregroundStyle(Color.gray600)
                        Spacer()
                        Text("오늘 22:28")
                            .bodyMediumMedium()
                            .foregroundStyle(Color.purple800)
                    }
                    .onTapGesture {
                        store.send(.startPickerTapped)
                    }
                    if store.isShowStartPicker {
                        DDatePicker(date: .constant(.now)) { date in
                            
                        }
                    }
                    
                    HStack {
                        Text("종료 시각")
                            .bodyMediumMedium()
                            .foregroundStyle(Color.gray600)
                        Spacer()
                        Text("오늘 22:28")
                            .bodyMediumMedium()
                            .foregroundStyle(Color.purple800)
                    }
                    .onTapGesture {
                        store.send(.endPickerTapped)
                    }
                    if store.isShowEndPicker {
                        DDatePicker(date: .constant(.now)) { date in
                            
                        }
                    }
                    Spacer()
                  
                   
                }
                .ignoresSafeArea(.keyboard)
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
                DDButton(action: {
                    store.send(.completeButtonTapped)
                })
            }
      
            .navigationBar(left: {
                DDBackButton(action: {})
                    .hidden(!store.isShowBackButton)
            })
        }
    }
}

#Preview {
    GoalView(store: Store(initialState: MakeGoal.State(), reducer: {
        MakeGoal()
    }))
}
