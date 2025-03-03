//
//  DDResultRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/6/25.
//

import SwiftUI

struct DDResultRow: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Image("iconReady")
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("14:30 ~ 18:00")
                        .font(.pretendard(size: 12, weight: .medium), lineHeight: 14)
                        .foregroundStyle(.gray500)
                        .padding(.bottom, 1)
                    Text("실무 과제 대비 연습")
                        .bodyLargeSemibold()
                        .foregroundStyle(.gray900)
                }
                .padding(.leading, 12)
                Spacer()
                
                Button(action: {}, label: {
                    Image(.iconRight)
                })
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 12)
        }
    }
}
