//
//  SplashView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct SplashView: View {
    let store: StoreOf<LoginCheck>
    var body: some View {
        WithPerceptionTracking {
            LaunchView()
            .ignoresSafeArea(.all)
            .onAppear {
                store.send(.loginCheck)
            }
        }
    }
}

struct LaunchView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Launch Screen", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

//#Preview {
//    SplashView()
//}
