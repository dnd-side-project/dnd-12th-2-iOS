//
//  HomeView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @Perception.Bindable var store: StoreOf<HomeNavigation>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Text("홈뷰")
                Button(action: {
                    store.send(.goToMyPage)
                }) {
                    Text("goToMypage")
                }
            }
        } destination: { store in
            switch store.case {
            case let .myPage(store):
                MyPageView(store: store)
            }
        }

    }
}

//#Preview {
//    HomeView()
//}
