//
//  GoalCompleteView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalCompleteView: View {
    let store: StoreOf<MakeGoal>
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("목표를 위한 \n첫 번째 계단을 올라봐요!")
                    .headingStyle2()
                    .foregroundStyle(Color.gray900)
                    .alignmentLeading()
                    .padding(.top, 16)
                
                Image("appLogoImage")
                    .padding(.top, 112)
                Text(store.goalInfo.goalTitle)
                    .headingStyle2()
                    .foregroundStyle(Color.gray900)
                    .padding(.top, 50)
                
                Text(store.goalInfo.planTitle)
                    .bodyLargeSemibold()
                    .foregroundStyle(Color.gray900)
                
                Text(store.resultTimeStr)
                    .bodySmallRegular()
                    .foregroundStyle(Color.gray600)
                
                Spacer()
                
                DDButton(action: {
                    store.send(.completeButtonTapped)
                })
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
//    GoalCompleteView()
//}
