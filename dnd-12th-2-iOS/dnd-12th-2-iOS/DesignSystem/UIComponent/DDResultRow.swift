//
//  DDResultRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/6/25.
//

import SwiftUI

struct DDResultRow: View {
    let plan: Plan
    let action: () -> Void
    
    var timeFormat: String {
        "\(plan.startDate.toTimeFormat()) ~ \(plan.endDate.toTimeFormat())"
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                plan.resultType.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        action()
                    }
                VStack(alignment: .leading, spacing: 0) {
                    Text(plan.resultType == .ready ? "\(timeFormat) 실행하셨나요?" :  timeFormat )
                        .font(.pretendard(size: 12, weight: .medium), lineHeight: 14)
                        .foregroundStyle(plan.resultType.titleColor)
                        .padding(.bottom, 1)
                    Text(plan.title)
                        .font(.pretendard(size: 14, weight: .semibold), lineHeight: 24)
                        .foregroundStyle(.gray900)
                }
                Spacer()
                
                Button(action: {}, label: {
                    Image(.iconRight)
                })
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
        }
        .background(plan.resultType.backgroundColor)
        .cornerRadius(12)
    }
}
