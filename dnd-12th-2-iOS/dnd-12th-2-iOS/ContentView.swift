//
//  ContentView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 1/22/25.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    @State private var isLaunch: Bool = true
    @State var text = ""
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {            
                VStack {           
            }
            .navigationBar(left: {
                Image(.appLogo)
            }, right: {
                HStack {
                    Image(.iconChart)
                    Image(.iconUser)
                }
            })
            .navigationDestination(for: String.self) { screenName in
                if screenName == "Onboarding" {
                    OnboardingView(store:  Store(initialState: OnboardingFeature.State()) {
                        OnboardingFeature()
                    })
                }
            }
        }
        
    }
}

//#Preview {
//    ContentView()
//}
