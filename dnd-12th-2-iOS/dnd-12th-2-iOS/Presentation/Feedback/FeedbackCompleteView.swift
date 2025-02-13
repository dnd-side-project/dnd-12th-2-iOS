//
//  FeedbackCompleteView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI
import ComposableArchitecture
struct FeedbackCompleteView: View {
    var body: some View {
        WithPerceptionTracking {
            
            Text("계획을 달성했어요! \n한 걸음 더 성장한 당신을 응원해요.")
                .font(.pretendard(size: 22, weight: .bold), lineHeight: 31)
                .foregroundStyle(Color.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 20)
            
            CompleteCell(completeType: .success)
            
            Spacer()
            
            DDButton(title:"다음",backgroundColor: .purple500, action: {})
        }
        .padding(.horizontal, 16)
        .background(alignment: .top, content: {
            Image("partyBackground")
                .offset(y: -48.0)
                .allowsHitTesting(false)
                .ignoresSafeArea()
        })
        .navigationBar(left: {
            DDBackButton(action: {print("1")})
        })
        
    }
}

#Preview {
    FeedbackCompleteView()
}
