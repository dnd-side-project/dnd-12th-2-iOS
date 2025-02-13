//
//  CompleteList.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/13/25.
//

import SwiftUI

struct CompleteList: View {
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(1...3, id: \.self) { index in
                HStack(alignment: index != 3 ? .top : .center, spacing: 12) {
                    Circle()
                        .foregroundStyle(Color.white)
                        .frame(width: 28, height: 28, alignment: .top)
                        .overlay(Image("iconFail"))
                    
                    VStack(spacing: 4) {
                        Text("운동 1시간 하기")
                            .font(.pretendard(size: 14, weight: .semibold))
                            .foregroundStyle(Color.gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if index != 3 {
                            Text("진행 상황을 수시로 확인해요.")
                                .font(.pretendard(size: 12, weight: .medium))
                                .foregroundStyle(Color.gray700)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.gray100)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    Spacer()
                }
       
            }
        }
        .background(alignment: .leading, content: {
            Image("historyLine")
                .offset(x: 14)
        })
        .clipped()
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

#Preview {
    CompleteList()
}
