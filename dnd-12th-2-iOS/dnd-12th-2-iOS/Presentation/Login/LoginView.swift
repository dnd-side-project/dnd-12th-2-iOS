//
//  LoginView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture
import AuthenticationServices

struct LoginView: View {
    @Perception.Bindable var store: StoreOf<LoginNavigation>
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                ZStack(alignment: .bottom) {
                    Image("imgBackground")
                    
                    VStack {
                        Text("빠르게 실패하세요. \n그리고 \n도달과 함께 개선하세요.")
                            .headingStyle2()
                            .alignmentLeading()
                            .foregroundStyle(Color.gray900)
                            .padding(.top, 77)
                        
                        Spacer()
                        
                        DDButton(image: Image("iconApple"),
                                 imageSize: 20,
                                 title: "애플 로그인",
                                 font: .pretendard(size: 16, weight: .medium),
                                 backgroundColor: .black,
                                 cornerRadius: 8) {}
                            .overlay {
                                SignInWithAppleButton(
                                    onRequest: { request in
                                        request.requestedScopes = [.fullName, .email]},
                                    onCompletion: { result in
                                        switch result {
                                        case let .success(authorization):
                                            store.send(.appleLoginButtonTapped(authorization))
                                            break
                                        case .failure:
                                            break
                                        }
                                    }
                                )
                                .blendMode(.overlay)
                            }
                            .padding(.bottom, 53)
                    }
                    .padding(.horizontal, 20)
                }
                .ignoresSafeArea(.container, edges: .bottom)
            } destination: { store in
                switch store.case {
                case let .complete(store):
                    OnboardingCompleteView(store: store)
                case let .onboarding(store):
                    OnboardingView(store: store)
                case let .goal(store):
                    GoalView(store: store)
                case let .goalComplete(store):
                    GoalCompleteView(store: store)
                }
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
