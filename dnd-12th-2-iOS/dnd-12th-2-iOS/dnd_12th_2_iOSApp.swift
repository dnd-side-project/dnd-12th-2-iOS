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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(store:  Store(initialState: RootFeature.State()) {
                RootFeature()
            })
            .onAppear {
//                KeyChainManager.deleteItem(key: .accessToken)
//                KeyChainManager.deleteItem(key: .refreshToken)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            guard error == nil else {
                print("Error while requesting permission for notifications.")
                return
            }
            
            print("Success while requesting permission for notifications.")
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken, "deviceToken!")
    }
}
