//
//  DDBackButton.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//

import SwiftUI

struct DDBackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Image(.iconBackBtn)
        })
    }
}

#Preview {
    DDBackButton(action: {})
}
