//
//  MainView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/5/25.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @Perception.Bindable var store: StoreOf<MainNavigation>
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Button(action: {
                        store.send(.goToHome)
                    }, label: {
                        Text("goToHome")
                    })
                }
            } destination: { store in
                switch store.case {
                case let .home(store):
                    HomeView(store: store)
                }
            }
        }
        
    }
}

//#Preview {
//    MainView()
//}
