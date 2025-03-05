//
//  FirstGoalView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import SwiftUI
import ComposableArchitecture

struct FirstGoalView: View {
    let store: StoreOf<FirstGoalFlow>
    var body: some View {
        Button(action: {
            store.send(.goToMain)
        }, label: {
            Text("goToMain")
        })
    }
}

//#Preview {
//    FirstGoalView()
//}
