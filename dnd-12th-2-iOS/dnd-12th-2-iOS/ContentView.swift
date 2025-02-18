//
//  ContentView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 1/22/25.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<RootFeature>
    
    var body: some View {
        SwitchStore(self.store) { state in
            switch state {
            case .loginCheck:
                CaseLet(/RootFeature.State.loginCheck, action: RootFeature.Action.loginCheck) {
                    SplashView(store: $0)
                }
            case .loggedIn:
                CaseLet(/RootFeature.State.loggedIn, action: RootFeature.Action.loggedIn) {
                    MainTabView(store: $0)
                }
            case .loggedOut:
                CaseLet(/RootFeature.State.loggedOut, action: RootFeature.Action.loggedOut) {
                    LoginView(store: $0)                       
                }
            case .onboarding:
                CaseLet(/RootFeature.State.onboarding, action: RootFeature.Action.onboarding) {
                    OnboardingView(store: $0)
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
