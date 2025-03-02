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
                    Text("시간")
                        .font(.pretendard(size: 12, weight: .medium), lineHeight: 14)
                        .foregroundStyle(.purple500)
                        .padding(.bottom, 1)
                    Text("title")
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
        .background(.gray50)
        .cornerRadius(12)
    }
}
