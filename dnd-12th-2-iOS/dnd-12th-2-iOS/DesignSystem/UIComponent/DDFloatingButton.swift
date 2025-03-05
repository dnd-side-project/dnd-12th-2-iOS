//
//  DDFloatingButton.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI

struct DDFloatingButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 4) {
                Image("iconPlus")
                Text("계획 추가")
                    .bodyLargeSemibold()
                    .foregroundStyle(Color.white)
            }
            .padding(12)
        })
        .background(Color.purple500)
        .clipShape(Capsule())
        .offset(x: -16, y: -20)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

//#Preview {
//    DDFloatingButton()
//}
