//
//  CompleteListView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/13/25.
//

import SwiftUI
import ComposableArchitecture

struct CompleteListView: View {
    var body: some View {
        WithPerceptionTracking {
            
            Text("오늘의 계획을 완료하셨나요?")
                .font(.pretendard(size: 22, weight: .bold), lineHeight: 31)
                .foregroundStyle(Color.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 20)
            
            CompleteCell()
            
            Spacer()
            
            DDButton(title:"완료하지 못했어요", backgroundColor: .purple50, textColor: .purple500, action: {})
                .background(alignment: .bottomTrailing, content: {
                    Image("selecteComplete")
                        .offset(x: 43)
                })
            DDButton(title:"완료했어요",backgroundColor: .purple500, action: {})
        }
        .padding(.horizontal, 16)
        
        .navigationBar(left: {
            DDBackButton(action: {})
        })
    }
}

#Preview {
    CompleteListView()
}
