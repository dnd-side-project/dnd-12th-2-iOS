//
//  FeedbackResultView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/13/25.
//

import SwiftUI
import ComposableArchitecture
struct FeedbackResultView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                Text("좋아요! \n앞으로의 한 걸음도 기대할게요.")
                    .font(.pretendard(size: 22, weight: .bold), lineHeight: 31)
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                Text("6회 연속으로 계획에 도달했어요.")
                    .font(.pretendard(size: 16, weight: .medium), lineHeight: 24)
                    .foregroundStyle(Color.purple500)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                
                Image("successBadge")
                    .padding(.top, 32)
                
                CompleteList()
//                CompleteCell(completeType: .success)
                    .padding(.top, 31.92)
                Image("line")
                    .padding(.top, 20)
                Text("다음에는 이렇게 도달할까요?")
                    .font(.pretendard(size: 16, weight: .bold), lineHeight: 24)
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                HStack(spacing: 8) {
                    Image("iconCheckSmall")
                 Text("구체적인 계획을 설정해요.")
                        .font(.pretendard(size: 14, weight: .semibold))
                        .foregroundStyle(Color.gray800)
                    Spacer()
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .background(Color.purple100)
                .cornerRadius(8)
                .padding(.top, 12)
                                
                Spacer()
                
                DDButton(title: "확인", action: {})
            }
        }
        .padding(.horizontal, 16)
        .background(alignment: .top, content: {
            Image("partyBackground")
                .offset(y: -(48.0 + safeAreaInsets.top))
                .allowsHitTesting(false)
                .ignoresSafeArea()
        })
        .navigationBar(left: {
            DDBackButton(action: {})
        })
    }
}

#Preview {
    FeedbackResultView()
}
