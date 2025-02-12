//
//  CompleteCell.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI

struct CompleteCell: View {
    var body: some View {
        VStack {
            Text("12:28 ~ 16:28")
                .font(.pretendard(size: 12, weight: .regular))
                .foregroundStyle(Color.gray500)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("강남 카페에서 오픽 스터디")
                .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                .foregroundStyle(Color.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 13)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

#Preview {
    CompleteCell()
}
