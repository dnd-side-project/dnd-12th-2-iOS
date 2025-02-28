//
//  GoalCompleteView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct GoalCompleteView: View {
    let store: StoreOf<MakeGoal>
    var body: some View {
        VStack {
            Text("목표설정 완료!")
            Button(action: {
                store.send(.goToMainView)
            }, label: {
                Text("goToMain")
            })
        }
    }
}

//#Preview {
//    GoalCompleteView()
//}
