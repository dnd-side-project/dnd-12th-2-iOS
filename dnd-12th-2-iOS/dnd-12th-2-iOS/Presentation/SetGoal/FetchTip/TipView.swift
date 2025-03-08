//
//  TipView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/8/25.
//

import SwiftUI
import ComposableArchitecture

struct TipView: View {
    let store: StoreOf<FetchTip>
    
    var body: some View {
        HStack(spacing: 8) {
            Image("iconMagic")
            Text("진행 상황을 측정할 수 있도록 목표를 세워보세요.")
                .bodyMediumSemibold()
                .alignmentLeading()
                .foregroundStyle(Color.purple600)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color.purple50)
        .cornerRadius(8)
    }
}

//#Preview {
//    TipView()
//}
