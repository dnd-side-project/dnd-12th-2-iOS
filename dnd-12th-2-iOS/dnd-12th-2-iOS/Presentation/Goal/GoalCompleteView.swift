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
                Text("올해까지 오픽 AL받기")
                    .headingStyle2()
                    .foregroundStyle(Color.gray900)
                    .padding(.top, 50)
                
                Text("오픽노답 30페이지 스크립트 작성")
                    .bodyLargeSemibold()
                    .foregroundStyle(Color.gray900)
                
                Text("오늘 22:28 ~ 23:42")
                    .bodySmallRegular()
                    .foregroundStyle(Color.gray600)
                
                Spacer()
                
                DDButton(action: {})
            }
            .navigationBar(left: {
                DDBackButton(action: {})
            })
        }
    }
}

//#Preview {
//    GoalCompleteView()
//}
