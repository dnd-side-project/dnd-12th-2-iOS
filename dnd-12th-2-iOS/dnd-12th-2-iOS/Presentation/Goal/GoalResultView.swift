//
//  GoalResultView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalResultView: View {
    let store: StoreOf<GoalFeature>
    var body: some View {
        WithPerceptionTracking {
            Spacer()
                .frame(height: 16)
            Text("목표를 위한 \n첫 번째 계단을 올라봐요!")
                .font(.pretendard(size: 22, weight: .semibold), lineHeight: 31)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.gray900)
            
            Spacer()
            VStack(spacing: 0) {
                Image("appLogoImage")
                Spacer()
                    .frame(height: 50)
                Text("올해까지 오픽 AL받기")
                    .font(.pretendard(size: 22, weight: .bold), lineHeight: 31)
                    .foregroundStyle(Color.gray900)
                Spacer()
                    .frame(height: 12)
                Text("오픽노닥 30페이지 스크립트 작성")
                    .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                    .foregroundStyle(Color.gray900)
                Spacer()
                    .frame(height: 4)
                Text("오늘 22:28 ~ 23:42")
                    .font(.pretendard(size: 14, weight: .regular), lineHeight: 17)
                    .foregroundStyle(Color.gray600)
            }
            
            Spacer()
            Button(action: {}, label: {
                HStack(spacing: 0) {
                    Image("iconBell")
                    Spacer()
                        .frame(width: 6)
                    Text("30분 전 알림")
                        .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                        .foregroundStyle(Color.purple700)
                    Spacer()
                        .frame(width: 12)
                    Image("iconTriangle")
                }
                .padding(16)
            })
            .background(Color.purple50)
            .clipShape(Capsule())
            Spacer()
                .frame(height: 16)
            DDButton(action: {
                store.send(.resultButtonTapped)
            })
        }
        .padding(.horizontal, 16)
        .navigationBar(left: {
            DDBackButton(action: {
               
            })
        })
    }
}

//#Preview {
//    GoalResultView()
//}
