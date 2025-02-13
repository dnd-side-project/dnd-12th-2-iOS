//
//  SuccessView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/13/25.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        VStack(spacing: 0) {
            Text("축하해요! \n목표 달성을 성공했어요.")
                .font(.pretendard(size: 22, weight: .bold), lineHeight: 31)
                .foregroundStyle(Color.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, safeAreaInsets.top + 50)
            Spacer()
            
            DDProgessCard(title: "헬스장에서 근력 운동 30분 하기")
            
            HStack(spacing: 8) {
                DDButton(title: "새로운 목표 설정하기", backgroundColor: Color.purple100, textColor: Color.purple500, action: {})
                DDButton(title: "완료", action: {})
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 20)
        .background(Image("goalSuccess").offset(y: -10.0))
        .overlay(alignment: .top, content: {
            Image("partyBackground")
        })
    }
}

#Preview {
    SuccessView()
}
