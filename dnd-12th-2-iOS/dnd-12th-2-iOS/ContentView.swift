//
//  ContentView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 1/22/25.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<Navigation>
    
    var body: some View {
        SwitchStore(self.store) { state in
            switch state {
            case .loggedIn:
                CaseLet(/Navigation.State.loggedIn, action: Navigation.Action.loggedIn) {
                    HomeView(store: $0)
                }
            case .loggedOut:
                CaseLet(/Navigation.State.loggedOut, action: Navigation.Action.loggedOut) {
                    LoginView(store: $0)
                }
            case .loginCheck:
                CaseLet(/Navigation.State.loginCheck, action: Navigation.Action.loginCheck) {
                    SplashView(store: $0)
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
