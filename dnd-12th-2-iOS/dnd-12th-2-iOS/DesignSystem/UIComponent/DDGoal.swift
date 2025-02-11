//
//  DDGoal.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/11/25.
//

import SwiftUI

struct DDGoal: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 4) {
                VStack(spacing: 2) {
                    Image(.iconTriangle)
                        .rotationEffect(.degrees(180))
                    Image(.iconTriangle)
                }
                
                Text(title)
                    .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                    .foregroundStyle(Color.gray900)
            }
            .padding(6)
        })
        .background(Color.gray50)
        .cornerRadius(6.0)
    }
}

#Preview {
    DDGoal(title: "", action: {})
}
