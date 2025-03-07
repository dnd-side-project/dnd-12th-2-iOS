//
//  DDResultRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/6/25.
//

import SwiftUI

struct DDResultRow: View {
    let planInfo: Plan
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                planInfo.image
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(planInfo.period)
                        .font(.pretendard(size: 12, weight: .medium), lineHeight: 14)
                        .foregroundStyle(.gray500)
                        .padding(.bottom, 1)
                    Text(planInfo.title)
                        .bodyLargeSemibold()
                        .foregroundStyle(.gray900)
                }
                .padding(.leading, 12)
                Spacer()
                
                Button(action: {}, label: {
                    if planInfo.resultType == .ready {
                        Text("실행하셨나요?")
                            .bodySmallSemibold()
                            .foregroundStyle(Color.purple600)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(Color.gray50)
                            .cornerRadius(6)
                    } else {
                        Image(.iconRight)
                    }
                })
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 12)
        }
        .background(.white)
        .cornerRadius(12)
    }
}
