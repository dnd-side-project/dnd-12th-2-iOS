//
//  SplashView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/9/25.
//

import SwiftUI
import ComposableArchitecture

struct SplashView: View {
    let store: StoreOf<SplashFeature>
    var body: some View {
        LaunchView()
        .ignoresSafeArea(.all)
        .onAppear {
            store.send(.loginCheck)
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
