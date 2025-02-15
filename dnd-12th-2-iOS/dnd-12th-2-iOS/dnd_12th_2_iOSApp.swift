//
//  dnd_12th_2_iOSApp.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 1/22/25.
//

import SwiftUI
import ComposableArchitecture
@main
struct dnd_12th_2_iOSApp: App {
    var body: some Scene {
        WindowGroup {            
            ContentView(store:  Store(initialState: RootFeature.State()) {
                RootFeature()
            })
        }
    }
}
