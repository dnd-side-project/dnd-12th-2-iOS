//
//  SetGoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import SwiftUI
import ComposableArchitecture

struct SetGoalView: View {
    let store: StoreOf<SetGoal>
    var body: some View {
        VStack {
            TipView(store: store.scope(state: \.fetchTip, action: \.fetchTip))
        }
    }
}

//#Preview {
//    SetGoalView()
//}
